# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'stocks'
set :repo_url, 'git@github.com:MarhicJeromeGIT/stocks.git'

set :rvm_ruby_version, '2.3.0@stocks'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'
set :linked_files, %w{config/database.yml config/secrets.yml .env config/unicorn_init.sh config/unicorn.rb}

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  # task :start do ; end
  # task :stop do ; end
  desc "Start unicorn"
  task :start do
    on roles(:app) do
      within current_path do
        with RAILS_ENV: fetch(:rails_env) do
          execute :bundle, :exec, "#{current_path}/config/unicorn_init.sh start"
        end
      end
    end
  end

  desc "Stop unicorn"
  task :stop do
    on roles(:app) do
      within current_path do
        execute "#{current_path}/config/unicorn_init.sh stop"
      end
    end
  end

  desc "restart of Unicorn"
  task :restart do
    on roles(:app) do
      within current_path do
        with RAILS_ENV: fetch(:rails_env) do
        #  execute "#{current_path}/config/unicorn_init.sh stop"
         execute "#{current_path}/config/unicorn_init.sh restart"
       end
      end
    end
  end

  after 'finishing', 'deploy:restart'    # app IS NOT preloaded
end