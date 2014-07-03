ENV['DATABASE_URL'] ||=

Sidekiq.configure_server do |config|
  # config.redis = { namespace: 'sidekiq' }
  config.redis = { url: 'redis://localhost:6379/0', namespace: 'sidekiq' }
  # require 'sidekiq/middleware/server/retry_jobs'
  # Sidekiq::Middleware::Server::RetryJobs::MAX_COUNT = 1
  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection
  end

  config.on(:startup) { puts 'Hello!' }
  config.on(:quiet) { puts 'Quiet down!' }
  config.on(:shutdown) { puts 'Goodbye!' }
end

unless Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379/0', namespace: 'sidekiq' }
  end
end
