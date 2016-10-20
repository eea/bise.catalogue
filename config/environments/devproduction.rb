require 'byebug'

Catalogue::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  config.cache_classes = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.serve_static_assets = true

  config.assets.compress = false

  config.eager_load = false

  config.assets.js_compressor = :uglifier

  config.assets.compile = true
  config.assets.compress = false

  config.assets.digest = true
  config.assets.debug = true

  # See everything in the log (default is :info)
  config.log_level = :debug
  config.logger = Logger.new(STDOUT)

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w()
  config.assets.precompile += %w(home.js)

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default_url_options = { :host => 'catalogue.biodiversity.europa.eu' }
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.sendmail_settings = { :arguments => '-i' }

  # Enable threaded mode
  # config.threadsafe!

  config.i18n.fallbacks = true

  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  config.active_record.mass_assignment_sanitizer = :strict

end
