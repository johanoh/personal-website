require "ostruct"

class ProjectsController < ApplicationController
  PROJECTS = {
      # "project1" => "Homelab"
      "project2" => "Personal Website"
  }.freeze

  def index
    @projects = PROJECTS.map do |id, name|
      OpenStruct.new(id: id, name: name)
    end
  end

  def show
    project_id = params[:id]

    if PROJECTS.key?(project_id)
      @project = project_id
    else
      head :not_found
    end
  end
end
