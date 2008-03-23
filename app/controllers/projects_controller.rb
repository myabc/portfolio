class ProjectsController < ApplicationController

  def show
    @project = Project.find_by_status_and_id(true, params[:id]) or raise ActiveRecord::RecordNotFound
  end

end