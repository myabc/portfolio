require 'erb'
#require 'config/shared_accelerator/accelerator_tasks'

set :application, "portfolio"
set :repository,  "http://alexcolesportfolio.com/svn/portfolio"
set :mongrel_port, 4036

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/alexbcoles/sites/#{application}"

set :user, "alexbcoles"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :subversion

set :domain, 'alexcolesportfolio.com'

role :app, domain
role :web, domain
role :db,  domain, :primary => true

# Example dependancies
depend :remote, :command, :gem
depend :remote, :gem, :mongrel, '>=1.0.1'
depend :remote, :gem, :rake, '>=0.7'

# =============================================================================
# MONGREL TASKS
# =============================================================================

desc "Start Mongrel for the first time and create the symlink"
task :spinner, :roles => :app do
  run "/usr/local/bin/mongrel_rails start -c /users/home/alexbcoles/web -p #{mongrel_port} -d -e production -a 127.0.0.1 -P /users/home/#{user}/var/run/mongrel-1-#{mongrel_port}.pid"
  run "rm -rf /home/#{user}/public_html;ln -s #{current_path}/public /home/#{user}/public_html"
end
 
desc "Restart Mongrel"
task :restart, :roles => :app do
  run "/usr/local/bin/mongrel_rails stop"
  run "/usr/local/bin/mongrel_rails start -c /users/home/alexbcoles/web -p #{mongrel_port} -d -e production -a 127.0.0.1 -P /users/home/#{user}/var/run/mongrel-1-#{mongrel_port}.pid"
  cleanup
end
