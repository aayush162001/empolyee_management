class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    # @q = Project.ransack(params[:q])
    # @projects = @q.result(distinct: true).accessible_by(current_ability)      
    @departments = Department.all
  end

  def show
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to @department, notice: 'Department was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @department.update(department_params)
      redirect_to @department, notice: 'Department was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @department.destroy
    redirect_to projects_path, notice: 'Department was successfully destroyed.'
  end

  private

  def set_project
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name)
  end
end
