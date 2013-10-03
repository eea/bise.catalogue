require 'capistrano-rbenv'
require "bundler/capistrano"

set :application, "catalogue"

set :rbenv_ruby_version, "1.9.3-p448"

set :repository,  "https://github.com/eea/bise.catalogue.git"
set :branch, "master"

set :user, "deployer"
set :password, "anboto83"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :copy
set :use_sudo, false

set :shared_children, shared_children + %w{public/uploads}

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "10.211.55.8"                          # Your HTTP server, Apache/etc
role :app, "10.211.55.8"                          # This may be the same as your `Web` server
role :db,  "10.211.55.8", :primary => true        # This is where Rails migrations will run
role :db,  "10.211.55.8"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

before "deploy:create_symlink", "assets:precompile"

namespace :assets do
    desc "Compile assets"
    task :precompile, :roles => :app do
        run "cd #{release_path} && rake RAILS_ENV=#{rails_env} assets:precompile"
    end
end

namespace :deploy do

    before "deploy:cold", "deploy:install_bundler"
    task :install_bundler, :roles => :app do
        run "type -P bundle &>/dev/null || { gem install bundler --no-rdoc --no-ri; }"
        run "mkdir -p ~/apps/#{application}/releases"
    end

    %w[start stop restart].each do |command|
        desc "#{command} unicorn server"
        task command, :roles => :app, :except => {:no_release => true} do
            run "/etc/init.d/unicorn_#{application} #{command}"
        end
    end

    after "deploy:setup", "deploy:setup_config"
    task :setup_config, :roles => :app do
        sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
        sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
        run "mkdir -p #{shared_path}/config"
        run "cp #{current_path}/config/database.example.yml #{current_path}/config/database.yml"
        # put File.read("#{current_path}/config/database.example.yml"), "#{shared_path}/config/database.yml"
        puts "Now edit the config files in #{shared_path}."
    end

    after "deploy:finalize_update", "deploy:symlink_config"
    task :symlink_config, :roles => :app do
        run "ln -nfs #{release_path}/config/database.yml #{shared_path}/config/database.yml"
    end

    desc "Make sure local git is in sync with remote."
    task :check_revision, :roles => :web do
        unless `git rev-parse HEAD` == `git rev-parse origin/master`
            puts "WARNING: HEAD is not the same as origin/master"
            puts "Run `git push` to sync changes."
            exit
        end
    end
    before "deploy", "deploy:check_revision"

end
