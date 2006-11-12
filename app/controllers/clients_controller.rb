class ClientsController < ApplicationController
  verify :only => [ 'show', 'edit', 'destroy' ],
         :params => :id,
         :add_flash => { :notice => 'Missing client ID.' },
         :redirect_to => { :action => 'list' }

  def destroy
    if request.post?
      Client.find(params[:id]).destroy
      flash[:notice] = 'The client was successfully destroyed.'
      redirect_to :action => 'list'
    else
      flash[:notice] = 'Click Destroy to destroy the client.'
      redirect_to :action => 'edit', :id => params[:id]
    end
  end

  def edit
    @client = Client.find(params[:id])
    if request.post?
      if @client.update_attributes(params[:client])
        flash[:notice] = 'The client was successfully edited.'
        redirect_to :action => 'show', :id => @client
      end
    end
  end

  def list
    @client_pages, @clients = paginate(:clients)
  end

  def new
    if request.post?
      @client = Client.new(params[:client])
      if @client.save
        flash[:notice] = 'A new client was successfully added.'
        redirect_to :action => 'list'
      end
    else
      @client = Client.new
    end
  end

  def show
    @client = Client.find(params[:id])
  end
end
