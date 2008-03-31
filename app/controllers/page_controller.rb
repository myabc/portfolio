class PageController < ApplicationController

  def show
    @page = Page.find_by_slug_and_status(params[:anything].join("/"), true) or raise ActiveRecord::RecordNotFound
  end

end