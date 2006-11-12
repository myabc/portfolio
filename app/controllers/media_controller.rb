class MediaController < ApplicationController
  verify :only => [ 'show', 'edit', 'destroy' ],
         :params => :id,
         :add_flash => { :notice => 'Missing medium ID.' },
         :redirect_to => { :action => 'list' }

  def destroy
    if request.post?
      Medium.find(params[:id]).destroy
      flash[:notice] = 'The medium was successfully destroyed.'
      redirect_to :action => 'list'
    else
      flash[:notice] = 'Click Destroy to destroy the medium.'
      redirect_to :action => 'edit', :id => params[:id]
    end
  end

  def edit
    @medium = Medium.find(params[:id])
    if request.post?
      if @medium.update_attributes(params[:medium])
        flash[:notice] = 'The medium was successfully edited.'
        redirect_to :action => 'show', :id => @medium
      end
    end
  end

  def list
    @medium_pages, @media = paginate(:media)
  end

  def new
    if request.post?
      @medium = Medium.new(params[:medium])
      if @medium.save
        flash[:notice] = 'A new medium was successfully added.'
        redirect_to :action => 'list'
      end
    else
      @medium = Medium.new
    end
  end

  def show
    @medium = Medium.find(params[:id])
  end
end
