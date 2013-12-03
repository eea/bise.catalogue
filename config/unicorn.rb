# root = "/home/deployer/apps/catalogue/current"
root = "/var/local/apps/catalogue/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.blog.sock"
worker_processes 4
preload_app true
timeout 300
