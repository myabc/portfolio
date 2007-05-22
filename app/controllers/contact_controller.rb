class ContactController < ApplicationController
  
  def list
    # TODO: revert this back to index
    render :action => 'index'
  end
  
  def index
    render :action => 'index'
  end
  
end