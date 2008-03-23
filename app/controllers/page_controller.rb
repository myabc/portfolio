class PageController < ApplicationController

  def show
    @page = Page.find_by_slug(params[:anything].join("/")) or raise ActiveRecord::RecordNotFound
  end

end