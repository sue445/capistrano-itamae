# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'dummy'
set :repo_url, 'ssh://git@github.com/sue445/capistrano-itamae.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/dummy'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh
set :format, :pretty

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

# via. http://qiita.com/sonots/items/c3d60a155094b839ea0f
def vagrant_ssh_config
  return @vagrant_ssh_config if @vagrant_ssh_config

  @vagrant_ssh_config = {}
  out = `vagrant ssh-config`
  out.each_line do |line|
    line.strip!
    key, value = line.split(" ", 2)

    if key && value
      value = $1 if value =~ /^"(.+)"$/

      @vagrant_ssh_config[key] = value
    end
  end
  @vagrant_ssh_config
end

def set_vagrant_user
  ssh_config = vagrant_ssh_config

  set :user, ssh_config["User"]
  set :ssh_options,
      user: ssh_config["User"],
      port: ssh_config["Port"],
      keys: [ssh_config["IdentityFile"]],
      forward_agent: ssh_config["ForwardAgent"] == "yes"
end

task :itamae do
  on roles(:all) do
    itamae_ssh "memcached.rb"
  end
end
