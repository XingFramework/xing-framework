require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module XingApp; end
APP_MODULE = XingApp

module APP_MODULE
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    config.active_record.raise_in_transactional_callbacks = true

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    config.i18n.enforce_available_locales = true
    config.i18n.default = :en

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :pasword_confirmation]

    ###### COPIED FROM PREVIOUS VERSION OF XING in commit a0f7e416 #######

    #observers are define in app/observers
    #config.active_record.observers = :sitemap_observer,
    #:page_snapshot_observer

    # Enable the asset pipeline
    config.assets.enabled = false

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    config.site_title = "Another Quality Xing App"
    allowed_origins = instance.secrets.allowed_origins
    config.middleware.insert_before Rack::Runtime, Rack::Cors do
        allow do
            origins allowed_origins
            resource '*',
            :headers => :any,
            :expose => ['Location', 'access-token', 'token-type', 'client', 'expiry', 'uid'],
            :methods => [:get, :post, :delete, :put, :patch, :options]
        end
    end
  end
end
