class DailyWorkReportsController < ApplicationController
  before_action :set_daily_work_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    # binding.pry
    # current_user
    # if current_user.project_manager? || current_user.leader?
      @q = current_user.daily_work_reports.ransack(params[:q])
      @daily_work_reports = @q.result(distinct: true).accessible_by(current_ability).order(current_date: :desc)
    # @daily_work_reports = DailyWorkReport.accessible_by(current_ability)
    # @daily_work_reports = DailyWorkReport.all.order(created_at: :desc)
    # end
  end

  def check_index
    # if user_signed_in?  
      
      # binding.pry
      
      a = EmailHierarchy.where("too like ?","%,#{current_user.id},%").or(EmailHierarchy.where("too like ?","#{current_user.id},%")).or(EmailHierarchy.where("too like ?","%,#{current_user.id}"))
      .pluck(:user_id)
      # a = EmailHierarchy.where("to like ?","%#{current_user.id.to_s}%").pluck(:user_id)
      # b = EmailHierarchy.where("cc like ?","%#{current_user.id.to_s}%").pluck(:user_id)
      b = EmailHierarchy.where("cc like ?","%,#{current_user.id},%").or(EmailHierarchy.where("cc like ?","#{current_user.id},%")).or(EmailHierarchy.where("cc like ?","%,#{current_user.id}"))
      .pluck(:user_id)
      @q = DailyWorkReport.where(user_id: (a+b).split(',')).ransack(params[:q])
      @daily_work_reports = @q.result(distinct: true).accessible_by(current_ability).order(current_date: :desc)
    # end
  end

  def show
  end

  def new
      # binding.pry 
      @daily_work_report = DailyWorkReport.new
  end

  # def create
  #   @daily_work_report = DailyWorkReport.new(daily_work_report_params)
  #   # if(@daily_work_report.valid?)
  #     binding.pry
  #     if @daily_work_report.save
  #       redirect_to @daily_work_report, notice: 'Daily work report was successfully created.'
  #     else
  #       render :new
  #     end
  #   # else
  #   #   redirect_to @daily_work_report
  #   # end
  # end
  def create

    @daily_work_report = DailyWorkReport.new(daily_work_report_params)
    # binding.pry

      if (@daily_work_report.current_date == Date.today || @daily_work_report.current_date == Date.yesterday) && current_user.id == params[:daily_work_report][:user_id].to_i
      # @daily_work_report.current_date = Time.now
        if Project.exists?(params[:daily_work_report][:project_id])
          if @daily_work_report.save
            # binding.pry
            if not current_user.email_hierarchy == nil
              DailyWorkReportMailer.new_work_report_notification(@daily_work_report).deliver_now
              redirect_to daily_work_reports_path, notice: 'Daily work report was successfully created.'
            else
              redirect_to daily_work_reports_path, notice: 'Daily work report was successfully created.'
            end
          else
            render :new, status: :unprocessable_entity
          end
        else
          redirect_to new_daily_work_report_path, alert: 'Invalid project selection.'
        end
      elsif not current_user.id == params[:daily_work_report][:user_id].to_i
        if Project.exists?(params[:daily_work_report][:project_id])
          if @daily_work_report.save
            # binding.pry
            if not current_user.email_hierarchy == nil
              DailyWorkReportMailer.new_work_report_notification(@daily_work_report).deliver_now
              redirect_to daily_work_reports_path, notice: 'Daily work report was successfully created.'
            else
              redirect_to daily_work_reports_path, notice: 'Daily work report was successfully created.'
            end
          else
            render :new, status: :unprocessable_entity
          end
        else
          redirect_to new_daily_work_report_path, alert: 'Invalid project selection.'
        end
      else
        redirect_to new_daily_work_report_path, alert: 'Choose Today date or yesterday.'
      
      end

  end
  
  def edit
  end

  def update
    if @daily_work_report.update(daily_work_report_params)
      redirect_to @daily_work_report, notice: 'Daily work report was successfully updated.'
    else
      render :edit
    end
  end
  # def update
  #     if @daily_work_report.update(daily_work_report_params)
  #       redirect_to daily_work_report_path(@daily_work_report), notice: 'Daily work report was successfully updated.'
  #     else
  #       render :edit
  #     end
  # end

  def destroy
    @daily_work_report.destroy
    redirect_to daily_work_reports_url, notice: 'Daily work report was successfully destroyed.'
  end
  
  def view_document
    @daily_work_reports = DailyWorkReport.all
    redirect_to daily_work_reports_url
  end
  private

  def set_daily_work_report
    @daily_work_report = DailyWorkReport.find(params[:id])
  end

  def daily_work_report_params
    params.require(:daily_work_report).permit(:current_date, :hours, :status, :user_id, :project_id, :task)
  end

end