class HolidaysController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_holiday, only: [:show, :edit, :update, :destroy]

  def index
    # @q = Project.ransack(params[:q])
    # @projects = @q.result(distinct: true).accessible_by(current_ability)      
    @holidays = Holiday.all
  end

  def show
  end

  def new
    @holiday = Holiday.new
  end

  def create
    @holiday = Holiday.new(holiday_params)
    if @holiday.save
      redirect_to @holiday, notice: 'Holiday was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @holiday.update(holiday_params)
      redirect_to @holiday, notice: 'Holiday was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @holiday.destroy
    redirect_to projects_path, notice: 'Holiday was successfully destroyed.'
  end

  private

  def set_holiday
    @holiday = Holiday.find(params[:id])
  end

  def holiday_params
    params.require(:holiday).permit(:title, :holiday_date)
  end

end
