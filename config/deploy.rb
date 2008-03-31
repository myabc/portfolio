set :application, "portfolio.com"

set :repository,  "git://github.com/fesplugas/portfolio.git"

set :deploy_to, "/home/fesplugas/public_html/#{application}"
set :scm, :git

role :app, "ordinarycode.com"
role :web, "ordinarycode.com"
role :db,  "ordinarycode.com", :primary => true

desc "Starts the application"
deploy.task :start, :roles => :app do
  run "#{deploy_to}/current/script/process/spawner -p 10500 -i 1 -e production"
end

desc "Stops the application"
deploy.task :stop, :roles => :app do
  run "#{deploy_to}/current/script/process/reaper -a kill"
end