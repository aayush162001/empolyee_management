class EmailHierarchyController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    # @projects = Project.all
    @email_hierarchy = EmailHierarchy.all
  end

  def show
  end

  def new
    
    # binding.pry
    
    @email_hierarchy = EmailHierarchy.new
  end

  def create
    
    binding.pry
    
    @email_hierarchy = EmailHierarchy.new(email_hierarchy_params)
    if @email_hierarchy.save
      redirect_to @email_hierarchy, notice: 'Email Hierarchy was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @email_hierarchy.update(email_hierarchy_params)
      redirect_to @email_hierarchy, notice: 'Email Hierarchy was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @email_hierarchy.destroy
    redirect_to projects_path, notice: 'Email Hierarchy was successfully destroyed.'
  end

  private

  def set_project
    @email_hierarchy = EmailHierarchy.find(params[:id])
  end

  def email_hierarchy_params
    
    binding.pry
    
    params.require(:email_hierarchy).permit(:user_id,:to,:cc)
  end

end
