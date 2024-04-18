# frozen_string_literal: true
lock "~> 3.18.0"

server '52.68.227.154', port: 22, roles: %i[web app db], primary: true
set :repo_url, "https://github.com/kyhuuhai/rails_7_with_docker.git"
set :application, ENV["HOST"]
set :user,            'deploy'
set :ssh_options, {
    keys: %w(~/.ssh/id_rsa),
    user: fetch(:user),
    forward_agent: true,
    auth_methods: %w(publickey),
    port: 22
}
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

set :stage, :production
set :branch, 'main'
