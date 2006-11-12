class RolesController < ApplicationController
  verify :only => [ 'show', 'edit', 'destroy' ],
         :params => :id,
         :add_flash => { :notice => 'Missing role ID.' },
         :redirect_to => { :action => 'list' }

  def destroy
    if request.post?
      Role.find(params[:id]).destroy
      flash[:notice] = 'The role was successfully destroyed.'
      redirect_to :action => 'list'
    else
      flash[:notice] = 'Click Destroy to destroy the role.'
      redirect_to :action => 'edit', :id => params[:id]
    end
  end

  def edit
    @role = Role.find(params[:id])
    if request.post?
      if @role.update_attributes(params[:role])
        flash[:notice] = 'The role was successfully edited.'
        redirect_to :action => 'show', :id => @role
      end
    end
  end

  def list
    @role_pages, @roles = paginate(:roles)
  end

  def new
    if request.post?
      @role = Role.new(params[:role])
      if @role.save
        flash[:notice] = 'A new role was successfully added.'
        redirect_to :action => 'list'
      end
    else
      @role = Role.new
    end
  end

  def show
    @role = Role.find(params[:id])
  end
end
