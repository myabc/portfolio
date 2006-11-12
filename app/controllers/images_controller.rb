class ImagesController < ApplicationController
  before_filter :login_required
  scaffold :image
  
  def new
    @images = Image.find :all
    @imagesets = Imageset.find :all
    @image = Image.new
  end
  
  def create
    @image = Image.create(params[:image])
    redirect_to :action => 'new'
  end
  
  def clean
    Image.destroy_all
    redirect_to :action => 'new'
  end
  
end