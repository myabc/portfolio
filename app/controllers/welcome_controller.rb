class WelcomeController < ApplicationController

  def index
    @projects = Project.find(:all, :conditions => { :status => true })
  end

end