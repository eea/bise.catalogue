# root = "/home/deployer/apps/catalogue/current"
root = "/app"
working_directory root
pid "#{root}/tmp/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.blog.sock"
worker_processes 4
preload_app true
timeout 300

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end