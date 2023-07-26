class DesignationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    # @q = Project.ransack(params[:q])
    # @projects = @q.result(distinct: true).accessible_by(current_ability)      
    @designations = Designation.all
  end

  def show
  end

  def new
    @designation = Designation.new
  end

  def create
    @designation = Designation.new(designation_params)
    if @designation.save
      redirect_to @designation, notice: 'Designation was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @designation.update(designation_params)
      redirect_to @designation, notice: 'Designation was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @designation.destroy
    redirect_to projects_path, notice: 'Designation was successfully destroyed.'
  end

  private

  def set_project
    @designation = Designation.find(params[:id])
  end

  def designation_params
    params.require(:designation).permit(:name)
  end

end
