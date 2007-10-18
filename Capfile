load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

# =======================
#    For Mongrel Apps
# =======================

namespace :deploy do

  task :start, :roles => :app do
    run "/usr/local/bin/mongrel_rails start -c /users/home/alexbcoles/web -p #{mongrel_port} -d -e production -a 127.0.0.1 -P /users/home/#{user}/var/run/mongrel-1-#{mongrel_port}.pid"
    run "rm -rf /home/#{user}/public_html;ln -s #{current_path}/public /home/#{user}/public_html"
  end

  task :restart, :roles => :app do
    run "/usr/local/bin/mongrel_rails stop -P /users/home/#{user}/var/run/mongrel-1-#{mongrel_port}.pid"
    run "/usr/local/bin/mongrel_rails start -c /users/home/alexbcoles/web -p #{mongrel_port} -d -e production -a 127.0.0.1 -P /users/home/#{user}/var/run/mongrel-1-#{mongrel_port}.pid"
    cleanup
  end

end