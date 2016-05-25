# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.taopodcast.com"

# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'

# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host =
  "https://s3.amazonaws.com/#{ENV['AWS_BUCKET']}/"

# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  add( "/" )
  add( "/about" )
  add( "/photos" )
end
