require 'aws-sdk'
require 'pathname'
require 'storage_client'

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
    puts "BUCKET: #{ENV['AWS_BUCKET']}"
    puts "Pushing assets to S3..."
    StorageClient.upload_relative_path( "tmp/sitemaps", "sitemaps" )
    puts "Saved tmp/sitemaps to S3"
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


