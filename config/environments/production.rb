Catalogue::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # # Code is not reloaded between requests
  # config.cache_classes = true
  #
  # # Full error reports are disabled and caching is turned on
  # config.consider_all_requests_local       = false
  # config.action_controller.perform_caching = true
  #
  # # Disable Rails's static asset server (Apache or nginx will already do this)
  #
  # config.serve_static_assets = true
  #
  # # Compress JavaScripts and CSS
  # config.assets.compress = true
  #
  # config.eager_load = true
  #
  # # config.assets.css_compressor = :yui
  # config.assets.js_compressor = :uglifier
  #
  # # Don't fallback to assets pipeline if a precompiled asset is missed
  # config.assets.compile = true
  #
  # # Generate digests for assets URLs
  # config.assets.digest = true

  config.cache_classes = false

  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default_url_options = { :host => 'bise.catalogue.dev' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true


  # Defaults to nil and saved in location specified by config.assets.prefix
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w()
  #config.assets.precompile += %w(home.js)

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  #config.action_mailer.default_url_options = { :host => 'catalogue.biodiversity.europa.eu' }
  #config.action_mailer.delivery_method = :sendmail
  #config.action_mailer.sendmail_settings = { :arguments => '-i' }

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  #tibi
    ActiveRecord::Base.logger = Logger.new(STDOUT)
end
