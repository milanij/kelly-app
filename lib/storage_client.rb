class StorageClient
  @@storage_client = nil
  @@buckets = nil

  class <<self
    def storage_client(
      region=nil,
      access_key_id=nil,
      secret_access_key=nil,
      force=false
    )
      if force || !@@storage_client
        access_key_id = ENV['AWS_ACCESS_KEY_ID'] unless access_key_id

        secret_access_key =
          ENV['AWS_SECRET_ACCESS_KEY'] unless secret_access_key

        region = ENV['AWS_REGION'] unless region

        @@storage_client = Aws::S3::Client.new(
          access_key_id: access_key_id,
          secret_access_key: secret_access_key,
          region: region
        )
      end

      @@storage_client
    end


    def bucket(
      bucket_name=nil,
      region=nil,
      access_key_id=nil,
      secret_access_key=nil,
      force=false
    )
      @@buckets = {} unless @@buckets
      bucket_name = ENV['AWS_BUCKET'] unless bucket_name

      if force || !@@buckets[bucket_name]
        @@buckets[bucket_name] = Aws::S3::Resource.new(
          client: storage_client(
            region,
            access_key_id,
            secret_access_key,
            force
          )
        ).bucket(
          bucket_name
        )
      end

      @@buckets[bucket_name]
    end


    def upload_relative_path(
      local_relative_path,
      object_key,
      bucket_name=nil,
      region=nil,
      access_key_id=nil,
      secret_access_key=nil,
      force=false
    )
      # Pass a Rails.root-relative path to this method

      # Please note, the bucket name must exist
      local_path = Rails.root.join( local_relative_path )

      return unless File.exists?(local_path)

      upload(
        local_path,
        object_key,
        bucket_name,
        region,
        access_key_id,
        secret_access_key,
        force
      )
    end


    def upload_text(
      text,
      object_key,
      bucket_name=nil,
      region=nil,
      access_key_id=nil,
      secret_access_key=nil,
      force=false,
      cleanup=true
    )
      # Pass a string to this method

      # Please note, the bucket name must exist

      local_path = Rails.root.join( 'tmp', object_key )

      FileUtils.mkdir_p( File.dirname( local_path ) )

      File.open( local_path, 'w' ) do |f|
        f.puts text
      end

      unless File.file?( local_path )
        raise "Could not create #{local_path}"
      end

      upload(
        local_path,
        object_key,
        bucket_name,
        region,
        access_key_id,
        secret_access_key,
        force
      )

      if cleanup
        File.delete( local_path )
      end
    end


    def upload(
      local_path,
      object_key,
      bucket_name=nil,
      region=nil,
      access_key_id=nil,
      secret_access_key=nil,
      force=false
   )
      # Does not local_path to Rails.root, so best to pass an absolute path
      # to this method

      # Please note, the bucket name must exist

      file_type = File.ftype( local_path )
      if file_type == "directory"
        Dir.foreach( local_path ) do |file|
          next if file =~ /\A\.+\z/  # Don't upload . or ..

          upload(
            File.join( local_path, file ),
            File.join( object_key, file ),
            bucket_name,
            region,
            access_key_id,
            secret_access_key,
            force
          )
        end
      elsif file_type == "file"

        # Load credentials

        s3_bucket = bucket(
          bucket_name,
          region,
          access_key_id,
          secret_access_key,
          force
        )

        begin
          s3_object = s3_bucket.object( object_key )

          File.open( local_path, 'rb' ) do |file|
            s3_object.put( body: file )
          end
        rescue
          Honeybadger.notify( error_message: $!.message )
          Rails.logger.error( $!.message )
          raise $!
        end
      end
    end
  end
end
