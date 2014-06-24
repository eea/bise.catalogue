Sidekiq.configure_server do |config|
  config.redis = { namespace: 'sidekiq' }
  require 'sidekiq/middleware/server/retry_jobs'
  Sidekiq::Middleware::Server::RetryJobs::MAX_COUNT = 1
end

unless Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { namespace: 'sidekiq' }
  end
end