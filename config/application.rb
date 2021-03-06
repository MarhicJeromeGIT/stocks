require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Stocks
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = "Paris"
    config.autoload_paths << Rails.root.join('lib')
    
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

    I18n.available_locales = [:fr, :en, :jp]
    I18n.default_locale = :fr

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options], expose: '*', credentials: true
      end
    end
  end
end
