require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KellyApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.paperclip_defaults = {
      storage: :s3,
      s3_region: ENV['AWS_REGION'],
      s3_credentials: {
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        access_key_secret: ENV['AWS_SECRET_ACCESS_KEY']
      },
      path: "/#{ENV['APP_NAME']}/uploads/:class/:attachment/:id_partition/"\
            ":style.:extension",
      bucket: ENV['AWS_BUCKET'],
      s3_protocol: 'https',
      default_url: '/assets/missing_images/:class/:attachment/:style.png'
    }
  end
end
