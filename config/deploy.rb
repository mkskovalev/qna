# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "qna"
set :repo_url, "git@github.com:mkskovalev/qna.git"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/qna"
set :deploy_user, 'deployer'

set :branch, :main

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

after 'deploy:publishing', 'unicorn:restart'

namespace :config do
  desc "Symlink application config files."
  task :env_symlink do
    on roles(:app) do
      execute "ln -s #{shared_path}/config/app_environment_variables.rb #{release_path}/config/app_environment_variables.rb"
    end
  end
end

after "deploy", "config:env_symlink"
