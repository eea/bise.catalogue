
Sidekiq.configure_server do |config|
  # config.redis = { namespace: 'sidekiq' }
  config.redis = { url: REDIS_CONFIG["#{Rails.env.downcase}"]["url"], namespace: 'sidekiq' }
  # require 'sidekiq/middleware/server/retry_jobs'
  # Sidekiq::Middleware::Server::RetryJobs::MAX_COUNT = 1
  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection
  end

  config.on(:startup) { puts 'Sidekiq started!' }
  config.on(:quiet) { puts 'Sidekiq quiet!' }
  config.on(:shutdown) { puts 'Sidekiq stopped!' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: REDIS_CONFIG["#{Rails.env.downcase}"]["url"], namespace: 'sidekiq' }
end
