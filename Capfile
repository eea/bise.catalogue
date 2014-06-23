require 'capistrano/sidekiq'
# require 'capistrano/sidekiq/monit' #to require monit tasks # Only for capistrano3

load 'deploy'
# Uncomment if you are using Rails' asset pipeline
load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks
