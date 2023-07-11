class ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
      @q = Project.ransack(params[:q])
      @projects = @q.result(distinct: true).accessible_by(current_ability)      
      # @projects = Project.all
    end
  
    def show
    end
  
    def new
      @project = Project.new
    end
  
    def create
      @project = Project.new(project_params)
      if @project.save
        redirect_to @project, notice: 'Project was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @project.update(project_params)
        redirect_to @project, notice: 'Project was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @project.destroy
      redirect_to projects_path, notice: 'Project was successfully destroyed.'
    end
  
    private
  
    def set_project
      @project = Project.find(params[:id])
    end
  
    def project_params
      params.require(:project).permit(:name)
    end
end
