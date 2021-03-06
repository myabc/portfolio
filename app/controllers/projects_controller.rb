class ProjectsController < ApplicationController
  
  before_filter :login_required, :except => [ :index, :show ]

  # GET /  (this is also the default route)
  # GET /projects
  # GET /projects.xml
  def index
    @media = Medium.find(:all, :order => "name")
    @tags  = Tag.find(:all, :order => "name")
    @statuses = [ "planned", "completed" ]
    
    #@projects = Project.find(:all, :order => "name")
    @projects = if tag_name = params[:tag]
      Tag.find_by_name(tag_name).projects.paginate :page => params[:page]
    else
      Project.find(:all).paginate :page => params[:page]
    end
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @projects.to_xml }
    end
  end
  
  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    @page_title = @project.name
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @project.to_xml }
    end
  end
  
  # GET /projects/new
  def new
    @project = Project.new
    
    # lookups
    @media = Medium.find(:all)
    @clients = Client.find(:all, :order => "name")
    @imagesets = Imageset.find(:all)
    @images = Image.find(:all)
    
  end
  
  # GET /projects/1;edit
  def edit
#    @project = Project.find(params[:id])
    
    # lookups
    @media = Medium.find(:all)
    @clients = Client.find(:all, :order => "name")
    @imagesets = Imageset.find(:all)
    @images = Image.find(:all)

    @project = Project.find_by_status_and_id(true, params[:id]) or raise ActiveRecord::RecordNotFound
  end
  
  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to project_url(@project) }
        format.xml  { head :created, :location => project_url(@project) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors.to_xml }
      end
    end
  end
  
  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])
    
    respond_to do |format|
      if @role.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to project_url(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors.to_xml }
      end
    end
  end
  
  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.xml  { head :ok }
    end
  end
  
  #######
  private
  #######
  
  
end
