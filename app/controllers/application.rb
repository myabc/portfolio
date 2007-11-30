class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  #before_filter :login_from_cookie
  
  #def authorize?(user)
  #  user.login = "alexbcoles"
  #end

  #before_filter :check_authentication,
  #              :check_authorization,
  #              :except => [:signin_form, :signin]
                
  #def check_authentication
  #  unless session[:user]
  #    session[:intended_action] = action_name
  #    session[:intended_controller] = controller_name      
  #    redirect_to :controller => 'admin', :action => "signin"
  #    return false
  #  end
  #end
  
  #def check_authorization
  #  user = User.find(session[:user])
  #  unless user.roles.detect{|role|
  #    role.rights.detect{|right|
  #      right.action == action_name && right.controller == self.class.controller_path ||
  #      right.action == "*" && right.controller == self.class.controller_path
  #      }
  #    }
  #    flash[:notice] = "You are not authorized to view the page you requested"
  #    request.env["HTTP_REFERER"] ? (redirect_to :back) : (redirect_to :controller => 'admin', :action => "signin")
  #  end
  #end
  
  #def signin
  #  if request.post?
  #    session[:user] = User.authenticate(params[:username], params[:password]).id
  #    redirect_to :action => session[:intended_action],
  #                :controller => session[:intended_controller]
  #  end
  #end
  
  #def signout
  #  session[:user] = nil
  #  redirect_to home_url
  #end

end