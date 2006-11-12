class ImagesetsController < ApplicationController
  
  before_filter :login_required
  scaffold :imageset
  
  def list
    @sets = Imageset.find(:all, :conditions => ["project_id = ?", params[:project_id]])
    render_scaffold
  end
  
  def update
    @set = Imageset.find(params[:id])
    if(@set.position > params[:Imageset][:position].to_i)
      Imageset.find(:all, :conditions => ["position >= ? AND position < ?", params[:Imageset][:position],@set.position]).each {|c| c.update_attribute(:position, c.position + 1)}     else       Imageset.find(:all, :conditions => ["position <= ? AND position > ?", params[:Imageset][:position],@set.position]).each {|c| c.update_attribute(:position, c.position - 1)}
    end
    if @set.update_attributes(params[:Imageset])
      redirect_to :action => 'Imageset'
    else
      redirect_to :action => 'edit', :id => params[:id]
    end
  end

  def create
    @set = Imageset.new(params[:Imageset])
    if @set.save and @set.insert_at(params[:Imageset][:position])
      flash[:notice] = 'Imageset was successfully created.'
      redirect_to :action => 'Imageset'
    else
      render :action => 'new'
    end
  end

  def update_positions
    params[:sortable_Imageset].each_with_index do |id, position|
      Imageset.update(id, :position => position+1)
    end
    @sets = Imageset.find(:all, :order => :position )
    render :layout => false , :action => :reorder
    render :text => 'updated sort order'
  end

  def reorder
    @sets = Imageset.find(:all, :order => :position )
  end
  
end