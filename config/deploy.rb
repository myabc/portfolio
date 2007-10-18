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

deploy.task :restart do
#  accelerator.smf_restart
#  accelerator.restart_apache
end
 
deploy.task :start do
#  accelerator.smf_start
#  accelerator.restart_apache
end
 
deploy.task :stop do
#  accelerator.smf_stop
#  accelerator.restart_apache
end
 
after :deploy, 'deploy:cleanup'