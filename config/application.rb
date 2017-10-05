require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CaptivePortal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.middleware.use OmniAuth::Builder do
      provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
        scope: 'email,public_profile'
      #provider :twitter
      #provider :google_oauth2
    end

    config.i18n.default_locale = :ja

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
