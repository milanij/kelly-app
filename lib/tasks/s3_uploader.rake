require 'aws-sdk'
require 'pathname'

class S3uploader
  class <<self
    def upload( local_path, aws_path )
      unless File.exists?(local_path)
        puts "That local_path is messed up."
        return
      end
      # Load credentials
      bucket_name = ENV['AWS_BUCKET']
      puts "BUCKET: #{bucket_name}"
      puts "Pushing assets to S3..."

      # Establish S3 connection
      client = Aws::S3::Client.new(
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region: ENV['AWS_REGION']
      )

      Dir.glob( Rails.root.join( local_path, "**", "*" ) ).each do |file|
        next if File.directory?( file )
        abs_path = Pathname.new( Dir.glob( Rails.root.join( local_path ) ).first )
        rel_path = Pathname.new( file )
        upload_path = File.join( aws_path, rel_path.relative_path_from( abs_path ) )

        begin
          resource = Aws::S3::Resource.new(client: client)
          bucket = resource.bucket(bucket_name)

          object = bucket.object(upload_path)
          object.put({body: file, acl: "public-read"})
        rescue
          Rails.logger.error( $!.message )
          raise $!
        end
        puts "Saved #{upload_path} to S3"
      end
    end
  end
end

class Rake::Task
  def replace &block
    @actions.clear
    prerequisites.clear
    enhance &block
  end
end

namespace 'sitemap' do
  desc 'Upload the sitemap files to S3'
  task :upload_to_s3 => :environment do
    S3uploader.upload( "tmp/sitemaps", "sitemaps" )
  end
end

Rake::Task["sitemap:create"].enhance do
  Rake::Task["sitemap:upload_to_s3"].invoke
end

Rake::Task["sitemap:refresh"].enhance do
  Rake::Task["sitemap:upload_to_s3"].invoke
end

Rake::Task["sitemap:refresh:no_ping"].enhance do
  Rake::Task["sitemap:upload_to_s3"].invoke
end
