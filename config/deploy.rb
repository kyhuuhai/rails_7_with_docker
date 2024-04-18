# frozen_string_literal: true

require 'dotenv'

# Don't change these unless you know what you're doing
set :pty,             false
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :init_system,     :systemd
set :rbenv_type, :user
set :rbenv_ruby, '3.2.2'

set :linked_files, %w[.env config/master.key]
append :linked_dirs, '.bundle'

# Default value for linked_dirs is []
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets public/uploads]

set :keep_releases, 4

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

before 'deploy:assets:precompile', 'deploy:yarn_install'

# Rake::Task["git:check"].clear
# Rake::Task["git:clone"].clear
# Rake::Task["git:update"].clear
# Rake::Task["deploy:migrate"].clear
# Rake::Task["deploy:migrating"].clear
# Rake::Task["deploy:assets:precompile"].clear

# namespace :git do
#   task :check do
#     # Do Work.
#   end

#   task :clone do
#     # Do Work.
#   end

#   task :update do
#     # Do Work.
#   end
# end

namespace :deploy do
  # task :migrate do
  #   # Do Work.
  # end


  # task :migrating do
  #   # Do Work.
  # end

  # task "assets:precompile" do
  #   # Do Work.
  # end

  # Trigger the task before publishing
  # before 'deploy:publishing', 'db:seed_fu'

  desc 'Run rake yarn:install'
  task :yarn_install do
    on roles(:app) do
      within release_path do
        execute("cd #{release_path} && yarn install --check-files")
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:stop'
      invoke 'deploy'
    end
  end

  desc 'Restart sidekiq'
  task :sidekiq_restart do
    on roles(:app) do
      execute "cd #{current_path}"
      execute "echo", "Denso@1sss234", "|", :sudo, "-S", :systemctl, :restart, 'webeigyou-sidekiq' , ''
    end
  end

  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
end

namespace :db do
  desc 'Resets DB without create/drop'
  task :reset do
    on primary :db do
      within release_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
        end
      end
    end
  end
end

after :deploy, 'puma:start'
after :deploy, 'deploy:sidekiq_restart'

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
