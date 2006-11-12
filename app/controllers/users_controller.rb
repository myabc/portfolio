class UsersController < ApplicationController
  verify :only => [ 'show', 'edit', 'destroy' ],
         :params => :id,
         :add_flash => { :notice => 'Missing user ID.' },
         :redirect_to => { :action => 'list' }

  def destroy
    if request.post?
      User.find(params[:id]).destroy
      flash[:notice] = 'The user was successfully destroyed.'
      redirect_to :action => 'list'
    else
      flash[:notice] = 'Click Destroy to destroy the user.'
      redirect_to :action => 'edit', :id => params[:id]
    end
  end

  def edit
    @user = User.find(params[:id])
    if request.post?
      if @user.update_attributes(params[:user])
        flash[:notice] = 'The user was successfully edited.'
        redirect_to :action => 'show', :id => @user
      end
    end
  end

  def list
    @user_pages, @users = paginate(:users)
  end

  def new
    if request.post?
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = 'A new user was successfully added.'
        redirect_to :action => 'list'
      end
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
