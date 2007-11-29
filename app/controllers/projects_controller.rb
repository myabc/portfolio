class ProjectsController < ApplicationController
  
  before_filter :login_required, :except => [ :index, :list, :view ]
  
  def destroy
    if request.post?
      Project.find(params[:id]).destroy
      flash[:notice] = 'The project was successfully destroyed.'
      redirect_to :action => 'list'
    else
      flash[:notice] = 'Click Destroy to destroy the project.'
      redirect_to :action => 'edit', :id => params[:id]
    end
  end
  
  def edit
    @project = Client.find(params[:id])
    if request.post?
      if @project.update_attributes(params[:client])
        @project.tag_with(params[:tag_list])
        flash[:notice] = 'The client was successfully edited.'
        redirect_to :action => 'show', :id => @project
      end
    end
    
    # lookups
    @media = Medium.find(:all)
    @clients = Client.find(:all, :order => "name")
    @imagesets = Imageset.find(:all)
    @images = Image.find(:all)
  end
  
  
  def index
    list
    render :action => 'list'
  end
  
  def list
    @tags = Tag.find(:all)
    @media = Medium.find(:all)
    
    #if short_name = params[:short_name]
    #  @client_scope = Client.find_by_short_name(short_name)
    #end
    
    @projects = Project.find(:all, :order => "name")
    #render :text => @client_scope.id
    
    #@projects = if tag_name = params[:id] 
    #    Tag.find_by_name(tag_name).tagged
    #  else
    #    Project.find_all
    #  end
    #@project_pages, @projects = paginate :project, :per_page =>20
  end  

  def new
    if request.post?
      @project = Project.new(params[:project])
      if @project.save
        flash[:notice] = 'A new project was successfully added.'
        redirect_to :action => 'list'
      end
    else
      @project = Project.new
    end
  end

  def show
    view
    render :action => 'view'
  end
  
  def view
    @project = Project.find(params[:id])
    @page_title = @project.name
  end
  
  #######
  private
  #######
  
  def client_scope
    
  end
  
end
