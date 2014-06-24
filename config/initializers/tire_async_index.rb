TireAsyncIndex.configure do |config|
  config.background_engine :sidekiq
  config.use_queue :document_indexer
end
