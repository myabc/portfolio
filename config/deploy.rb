require 'erb'
#require 'config/shared_accelerator/accelerator_tasks'

set :application, "portfolio"
set :domain, "alexcolesportfolio.com"
set :user, "alexbcoles"
set :repository,  "http://#{domain}/svn/#{application}/trunk"
set :use_sudo, false
set :deploy_to, "/home/alexbcoles/sites/#{application}"
set :mongrel_port, 4036

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :subversion

role :app, domain
role :web, domain
role :db,  domain, :primary => true

# Example dependancies
depend :remote, :command, :gem
depend :remote, :gem, :mongrel, '>=1.0.1'
depend :remote, :gem, :rake, '>=0.7'
