# Introductory SwitchTower config for TextDrive.
#
# ORIGINAL BY: Jamis Buck
#
# Docs: http://manuals.rubyonrails.com/read/chapter/98
#
# HIGHLY MODIFIED BY: Geoffrey Grosenbach boss@topfunky.com
#
# Docs: http://nubyonrails.com/pages/shovel
#
# USE AT YOUR OWN RISK! THIS SCRIPT MODIFIES FILES, MAKES DIRECTORIES, AND STARTS
# PROCESSES. FOR ADVANCED OR DARING USERS ONLY!
#
# DESCRIPTION
#
# This is a customized recipe for easily deploying lighttpd to TextDrive.
# It takes the instructions from five different manuals and puts them into a Switchtower
# Recipe.
#
# For full details, see http://nubyonrails.com/pages/shovel
#
# To setup lighty, first edit this file for the TextDrive account you are deploying.
#
# Then run:
#   rake remote:exec ACTION=setup_lighty
#
# This will create all the necessary config files for running lighttpd.
#
# From then, you can deploy your application to TextDrive with Switchtower's standard
#   rake deploy
#
# Or rollback with
#   rake rollback
# 
# NOTE: When editing on Windows, be sure to save with Unix line endings (LF).

#############
# Set these vars to work with your TextDrive Account

set :application, 'portfolio' # The one you are deploying.

# This is the user name that will be used when logging into the deployment boxes.
# Also used to build paths to your TextDrive home directory.
set :user, "alexbcoles"
set :txd_primary_domain, 'alexcolesportfolio.com' # The domain you ssh to for your server.
set :lighty_port, 8264 # The port given to you by TextDrive for running lighttpd

#############
# The rest should work automatically for a normal TextDrive setup
# if used with the setup_lighty action below.

# Assumes your SVN is setup like http://topfunky.net/svn/some_project_domain.com
set :repository, "http://#{txd_primary_domain}/svn/#{application}"
# For svn+ssh.
#set :repository, "svn+ssh://#{user}@#{txd_primary_domain}/home/#{user}/svn/#{application}"

set :deploy_to, "/home/#{user}/sites/#{application}"

set :restart_via, :run
set :use_sudo, false

# By default, the source control module (scm) is set to "subversion". You can
# set it to any supported scm:
set :scm, :subversion
# set :svn, '/path/to/bin/svn'

# gateway is optional, but allows you to specify the address of a computer that
# will be used to tunnel other requests through, such as when your machines are
# all behind a VPN or something

#set :gateway, "gateway.example.com"

# You can define any number of roles, each of which contains any number of
# machines. Roles might include such things as :web, or :app, or :db, defining
# what the purpose of each machine is. You can also specify options that can
# be used to single out a specific subset of boxes in a particular role, like
# :primary => true.

role :app, txd_primary_domain 
role :web, txd_primary_domain
role :db, txd_primary_domain

# =============================================================================
# Additional tasks for setting up lighttpd on TextDrive
# =============================================================================

desc "Make directories on TextDrive and setup lighttpd config"
task :setup_lighty do  
  write_lighty_config_file
  write_lighttpdctrl_script

  # Do initial setup and then get the new code for this site
  setup
  deploy

  # Start the lighty server
  set :lighttpdctrl_restart, "/home/#{user}/lighttpd/lighttpdctrl restart"
  set :lighttpdctrl_start, "/usr/local/sbin/lighttpd -f /home/#{user}/lighttpd/lighttpd.conf"
  run lighttpdctrl_start
  
  #run "/usr/local/sbin/lighttpd -f /home/#{user}/lighttpd/lighttpd.conf"

  # Schedule cron job to start when server restarts
  #run "crontab -l > /home/#{user}/lighttpd/crontab.conf" # Backup existing settings
  run "echo '@reboot #{lighttpdctrl_start}' >> /home/#{user}/lighttpd/crontab.conf"
  run "crontab /home/#{user}/lighttpd/crontab.conf" # Apply

  # TODO Rest of web-based server config
  #http://manuals.textdrive.com/read/chapter/61    
end


# No sudo access on txd :)
desc "Restart lighty"
task :restart, :roles => :app do
  run "/home/#{user}/lighttpd/lighttpdctrl restart"
end


desc "Write customized lighttpd.conf file to server."
task :write_lighty_config_file do
   
  # Make some folders
  run "if [ ! -d lighttpd/cache/compress ]; then mkdir -p lighttpd/cache/compress; fi"
  run "if [ ! -d var/run ]; then mkdir -p var/run; fi"
  run "if [ ! -d var/log ]; then mkdir var/log; fi"
  run "if [ ! -d sites ]; then mkdir sites; fi"

  # Make the config file
  buffer = render(:template => <<LIGHTY_CONFIG)
server.dir-listing = "disable" 
server.modules = ( "mod_rewrite",
                   "mod_access",
                   "mod_fastcgi",
                   #"mod_compress",
                   "mod_accesslog")

## a static document-root, for virtual-hosting take look at the
## server.virtual-* options
server.document-root        = "/home/<%= user %>/sites/<%= application %>/current/public/" 

## where to send error-messages to
server.errorlog             = "/home/<%= user %>/logs/lighttpd.error.log" 

# files to check for if .../ is requested
server.indexfiles           = ( "index.php", "index.html",
                                "index.htm", "index.rb")

# mimetype mapping
mimetype.assign             = (
  ".pdf"          =>      "application/pdf",
  ".sig"          =>      "application/pgp-signature",
  ".spl"          =>      "application/futuresplash",
  ".class"        =>      "application/octet-stream",
  ".ps"           =>      "application/postscript",
  ".torrent"      =>      "application/x-bittorrent",
  ".dvi"          =>      "application/x-dvi",
  ".gz"           =>      "application/x-gzip",
  ".pac"          =>      "application/x-ns-proxy-autoconfig",
  ".swf"          =>      "application/x-shockwave-flash",
  ".tar.gz"       =>      "application/x-tgz",
  ".tgz"          =>      "application/x-tgz",
  ".tar"          =>      "application/x-tar",
  ".zip"          =>      "application/zip",
  ".mp3"          =>      "audio/mpeg",
  ".m3u"          =>      "audio/x-mpegurl",
  ".wma"          =>      "audio/x-ms-wma",
  ".wax"          =>      "audio/x-ms-wax",
  ".ogg"          =>      "audio/x-wav",
  ".wav"          =>      "audio/x-wav",
  ".gif"          =>      "image/gif",
  ".jpg"          =>      "image/jpeg",
  ".jpeg"         =>      "image/jpeg",
  ".png"          =>      "image/png",
  ".xbm"          =>      "image/x-xbitmap",
  ".xpm"          =>      "image/x-xpixmap",
  ".xwd"          =>      "image/x-xwindowdump",
  ".css"          =>      "text/css",
  ".html"         =>      "text/html",
  ".htm"          =>      "text/html",
  ".js"           =>      "text/javascript",
  ".asc"          =>      "text/plain",
  ".c"            =>      "text/plain",
  ".conf"         =>      "text/plain",
  ".text"         =>      "text/plain",
  ".txt"          =>      "text/plain",
  ".dtd"          =>      "text/xml",
  ".xml"          =>      "text/xml",
  ".mpeg"         =>      "video/mpeg",
  ".mpg"          =>      "video/mpeg",
  ".mov"          =>      "video/quicktime",
  ".qt"           =>      "video/quicktime",
  ".avi"          =>      "video/x-msvideo",
  ".asf"          =>      "video/x-ms-asf",
  ".asx"          =>      "video/x-ms-asf",
  ".wmv"          =>      "video/x-ms-wmv",
  ".bz2"          =>      "application/x-bzip",
  ".tbz"          =>      "application/x-bzip-compressed-tar",
  ".tar.bz2"      =>      "application/x-bzip-compressed-tar" 
 )

#Server ID Header
server.tag                 = "lighttpd | TextDriven" 

#### accesslog module
accesslog.filename          = "/home/<%= user %>/logs/access_log" 

## deny access the file-extensions
#
# ~    is for backupfiles from vi, emacs, joe, ...
# .inc is often used for code includes which should in general not be part
#      of the document-root
url.access-deny             = ( "~", ".inc" )

######### Options that are good to be but not neccesary to be changed #######

## bind to port (default: 80)
server.port                =  <%= lighty_port %>

## bind to localhost (default: all interfaces)
#server.bind                = "grisu.home.kneschke.de" 

## to help the rc.scripts
server.pid-file            = "/home/<%= user %>/var/run/lighttpd.pid" 

###############
# To add other domains or subdomains, copy this section and replace your primary domain
# with the appropriate other domain.
#
$HTTP["host"] =~ "<%= application.gsub('.', '\\.') %>" {
  server.document-root = "/home/<%= user %>/sites/<%= application %>/current/public/"
  server.errorlog = "/home/<%= user %>/logs/<%= application %>.lighttpd-error.log"
#  accesslog.filename = "/home/<%= user %>/logs/access_log" 

  url.rewrite = ( "^/$" => "index.html", "^([^.]+)$" => "$1.html" )
  server.error-handler-404 = "/dispatch.fcgi" 

  fastcgi.server = ( ".fcgi" =>
    ( "localhost" =>
        (
          "socket"   => "/home/<%= user %>/sites/<%= application %>/lighttpd-fcgi.socket",
          "bin-path" => "/home/<%= user %>/sites/<%= application %>/current/public/dispatch.fcgi",
          "bin-environment" => ( "RAILS_ENV" => "production" ),
          "min-procs" => 1,
          "max-procs" => 2,
          "idle-timeout" => 60
        )
    )
  )
 } 
###############

## change uid to <uid> (default: don't care)
server.username            = "<%= user %>" 

## change uid to <uid> (default: don't care)
server.groupname           = "<%= user %>" 

#### compress module
# FIX Does each virtual sub-host need its own compress.cache-dir ?
#compress.cache-dir         = "/home/<%= user %>/lighttpd/cache/compress/" 
#compress.filetype          = ("text/plain", "text/html")

LIGHTY_CONFIG

  # Write the config file to disk
  put buffer, "lighttpd/lighttpd.conf" #, :mode => xxxx  
end


desc "Sets up lighttpd control script for starting, stopping, and restarting lighty"
task :write_lighttpdctrl_script do  
  buffer = render(:template => <<LIGHTTPDCTRL)
#!/bin/sh                                                                                            

#
# lighty update script to kill stray processes.
#
# AUTHOR: Jarkko Laine http://jlaine.net/blog
#

LIGHTTPD_CONF=/home/<%= user %>/lighttpd/lighttpd.conf
PIDFILE=/home/<%= user %>/var/run/lighttpd.pid
 
case "$1" in
    start)
      # Starts the lighttpd deamon                                                                         
      echo "Starting Lighttpd"
      lighttpd -f $LIGHTTPD_CONF
 
  ;;
    stop)
      # stops the daemon bt cat'ing the pidfile                                                            
	    echo "Stopping Lighttpd"
      kill `cat $PIDFILE`
      # kill the fastcgi processes, too                                                                    
		  ps auxww|grep 'ruby'|awk '{print $2}'|xargs kill -9
  ;;
    restart)
		  ## Stop the service regardless of whether it was                                                     
		  ## running or not, start it again.                                                                   
		  echo "Restarting Lighttpd"
      $0 stop
      $0 start
  ;;
    reload)
      # reloads the config file by sending HUP                                                             
		  echo "Reloading config"
      kill -HUP `cat $PIDFILE`
  ;;
    *)
      echo "Usage: lighttpdctrl (start|stop|restart|reload)"
      exit 1
  ;;
esac
LIGHTTPDCTRL
  
  put buffer, "lighttpd/lighttpdctrl", :mode => 0755
end


desc "Deletes all directories and contents made by setup_lighty"
task :teardown_lighty do
  
  run "rm -rf lighttpd"
  run "rm -rf var"
  run "rm -rf sites"

  # TODO Clear cron jobs that were setup

  # Kill processes
  run "killall -9 lighttpd"
  run "killall -9 ruby"

end


#desc "Start the spinner daemon, using local lighttpdctrl"
#task :spinner, :roles => :app do
#  run "/home/#{user}/lighttpd/lighttpdctrl restart"
#end



# =====================================
# Sample tasks from original deploy.rb
# Some may not work with TextDrive (spinner, etc.)
# =====================================

# Define tasks that run on all (or only some) of the machines. You can specify
# a role (or set of roles) that each task should be executed on. You can also
# narrow the set of servers to a subset of a role by specifying options, which
# must match the options given for the servers to select (like :primary => true)

desc <<DESC
An imaginary backup task. (Execute the 'show_tasks' task to display all
available tasks.)
DESC

task :backup, :roles => :db, :only => { :primary => true } do
  # the on_rollback handler is only executed if this task is executed within
  # a transaction (see below), AND it or a subsequent task fails.
  on_rollback { delete "/tmp/dump.sql" }

  run "mysqldump -u theuser -p thedatabase > /tmp/dump.sql" do |ch, stream, out|
    ch.send_data "thepassword\n" if out =~ /^Enter password:/
  end
end

# Tasks may take advantage of several different helper methods to interact
# with the remote server(s). These are:
#
# * run(command, options={}, &block): execute the given command on all servers
#   associated with the current task, in parallel. The block, if given, should
#   accept three parameters: the communication channel, a symbol identifying the
#   type of stream (:err or :out), and the data. The block is invoked for all
#   output from the command, allowing you to inspect output and act
#   accordingly.
# * sudo(command, options={}, &block): same as run, but it executes the command
#   via sudo.
# * delete(path, options={}): deletes the given file or directory from all
#   associated servers. If :recursive => true is given in the options, the
#   delete uses "rm -rf" instead of "rm -f".
# * put(buffer, path, options={}): creates or overwrites a file at "path" on
#   all associated servers, populating it with the contents of "buffer". You
#   can specify :mode as an integer value, which will be used to set the mode
#   on the file.
# * render(template, options={}) or render(options={}): renders the given
#   template and returns a string. Alternatively, if the :template key is given,
#   it will be treated as the contents of the template to render. Any other keys
#   are treated as local variables, which are made available to the (ERb)
#   template.

desc "Demonstrates the various helper methods available to recipes."
task :helper_demo do
  # "setup" is a standard task which sets up the directory structure on the
  # remote servers. It is a good idea to run the "setup" task at least once
  # at the beginning of your app's lifetime (it is non-destructive).
  setup

  buffer = render("maintenance.rhtml", :deadline => ENV['UNTIL'])
  put buffer, "#{shared_path}/system/maintenance.html", :mode => 0644
  sudo "killall -USR1 dispatch.fcgi"
  run "#{release_path}/script/spin"
  delete "#{shared_path}/system/maintenance.html"
end

# You can use "transaction" to indicate that if any of the tasks within it fail,
# all should be rolled back (for each task that specifies an on_rollback
# handler).

desc "A task demonstrating the use of transactions."
task :long_deploy do
  transaction do
    update_code
    disable_web
    symlink
    migrate
  end

  restart
  enable_web
end


desc "Used only for deploying when the spinner isn't running"
task :cold_deploy do
  transction do
    update_code
    symlink
  end

  spinner
end

