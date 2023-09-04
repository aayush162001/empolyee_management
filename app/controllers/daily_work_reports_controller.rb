class DailyWorkReportsController < ApplicationController
  before_action :set_daily_work_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    
    # current_user
    # if current_user.project_manager? || current_user.leader?
      
      
      
      category = (params[:category] or (params[:q][:category] if params[:q].present?))
      @selected_user = params[:selected_user]
      @selected_project = params[:selected_project]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      # binding.pry
      @daily_work_reports = fetch_products(category)
      # @q = current_user.daily_work_reports.ransack(params[:q])
      # @daily_work_reports = @q.result(distinct: true).accessible_by(current_ability).order(current_date: :desc)
    # @daily_work_reports = DailyWorkReport.accessible_by(current_ability)
    # @daily_work_reports = DailyWorkReport.all.order(created_at: :desc)
    # end
  end

  def check_index
    # if user_signed_in?  
      
      # binding.pry
      
      a = EmailHierarchy.where("too like ?","%,#{current_user.id},%").or(EmailHierarchy.where("too like ?","#{current_user.id},%")).or(EmailHierarchy.where("too like ?","%,#{current_user.id}")).or(EmailHierarchy.where("cc like ?","#{current_user.id}"))
      .pluck(:user_id)
      # a = EmailHierarchy.where("to like ?","%#{current_user.id.to_s}%").pluck(:user_id)
      # b = EmailHierarchy.where("cc like ?","%#{current_user.id.to_s}%").pluck(:user_id)
      b = EmailHierarchy.where("cc like ?","%,#{current_user.id},%").or(EmailHierarchy.where("cc like ?","#{current_user.id},%")).or(EmailHierarchy.where("cc like ?","%,#{current_user.id}")).or(EmailHierarchy.where("cc like ?","#{current_user.id}")).pluck(:user_id)
      # @qs = DailyWorkReport.where(user_id: (a+b).split(',')).ransack(params[:q])
      # @daily_work_reports = @qs.result(distinct: true).accessible_by(current_ability).order(current_date: :desc)
      @daily_work_reports = DailyWorkReport.where(user_id: (a+b)).accessible_by(current_ability).order(current_date: :desc)
    # end
  end

  def show
  end

  def new
      # binding.pry 
      @daily_work_report = DailyWorkReport.new
  end

  def create
    # binding.pry
    @daily_work_report = DailyWorkReport.new(daily_work_report_params)
    # binding.pry

      if (@daily_work_report.current_date == Date.today || @daily_work_report.current_date == Date.yesterday) && current_user.id == params[:daily_work_report][:user_id].to_i
        # binding.pry
        # @daily_work_report.current_date = Time.now
        if Project.exists?(params[:daily_work_report][:project_id])
          if @daily_work_report.save
            # binding.pry
            if not      @q = current_user.daily_work_reports.ransack(params[:q])
              @daily_work_reports = @q.result(distinct: true).accessible_by(current_ability).order(current_date: :desc)
            # @daily_work_reports = DailyWorkReport.accessible_by(current_ability)
            # @daily_work_reports = DailyWorkReport.all.order(created_at: :desc)
            # end current_user.email_hierarchy == nil
              DailyWorkReportMailer.new_work_report_notification(@daily_work_report).deliver_now
              redirect_to daily_work_reports_path, notice: 'Daily work report was successfully created.'
            else
              redirect_to daily_work_reports_path, notice: 'Daily work report was successfully created.'
            end
          else
            render :new, status: :unprocessable_entity
          end
        else
          @daily_work_report.errors.add(:project_id, "Select the Project selection. ")
          # if params[:daily_work_report][:current_date] == ""
            
          #   @daily_work_report.errors.add(:current_date, "Current Date can not be NIL ")
          # else 
          #   @daily_work_report.errors.add(:current_date, "Choose Today date or yesterday ")
          # end
          render :new, status: :unprocessable_entity
        end
      elsif not current_user.id == params[:daily_work_report][:user_id].to_i
        # binding.pry

        if Project.exists?(params[:daily_work_report][:project_id])
          if @daily_work_report.save
            if not current_user.email_hierarchy == nil
              DailyWorkReportMailer.new_work_report_notification(@daily_work_report).deliver_now
              redirect_to daily_work_reports_path(category: "other_work_reports"), notice: 'Daily work report was successfully created.'
            else
              redirect_to daily_work_reports_path(category: "other_work_reports"), notice: 'Daily work report was successfully created.'
            end
          else
            render :new, status: :unprocessable_entity
          end
        else
          # binding.pry
          @daily_work_report.errors.add(:project_id, "Select the Project selection. ")
          # query_params = { category: "other_work_reports" } # Replace with your query parameters
          # render :new, status: :unprocessable_entity
          # redirect_to new_daily_work_report_path(category: "other_work_reports")
          redirect_to new_daily_work_report_path(@daily_work_report,category: "other_work_reports", error: "Failed to update item", data: params[:daily_work_report])
        end
      else
        # binding.pry
        if params[:daily_work_report][:current_date] == ""
          
          @daily_work_report.errors.add(:current_date, "Current Date can not be NIL ")
        else 
          @daily_work_report.errors.add(:current_date, "Choose Today date or Yesterday date ")
        end
        # redirect_to new_daily_work_report_path,  alert: 'Choose Today date or yesterday.'
        # flash.now[:alert_date] = "Choose Today date or yesterday."
        render :new , status: :unprocessable_entity
      
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

  def fetch_products(category)
    # binding.pry
    if category == "other_work_reports"
      
      # binding.pry
      
      a = EmailHierarchy.where("too like ?","%,#{current_user.id},%").or(EmailHierarchy.where("too like ?","#{current_user.id},%")).or(EmailHierarchy.where("too like ?","%,#{current_user.id}")).or(EmailHierarchy.where("cc like ?","#{current_user.id}"))
      .pluck(:user_id)
      # a = EmailHierarchy.where("to like ?","%#{current_user.id.to_s}%").pluck(:user_id)
      # b = EmailHierarchy.where("cc like ?","%#{current_user.id.to_s}%").pluck(:user_id)
      b = EmailHierarchy.where("cc like ?","%,#{current_user.id},%").or(EmailHierarchy.where("cc like ?","#{current_user.id},%")).or(EmailHierarchy.where("cc like ?","%,#{current_user.id}")).or(EmailHierarchy.where("cc like ?","#{current_user.id}")).pluck(:user_id)
      # @qs = DailyWorkReport.where(user_id: (a+b).split(',')).ransack(params[:q])
      # @daily_work_reports = @qs.result(distinct: true).accessible_by(current_ability).order(current_date: :desc)
      q = DailyWorkReport.where(user_id: (a+b)) 
      q = q.where(user_id: @selected_user) if @selected_user.present?
      q = q.where(project_id: @selected_project) if @selected_project.present?
      q = q.where(current_date: @start_date..@end_date) if date_range_present?
      q.accessible_by(current_ability).order(current_date: :desc)    
      # end
    else
      
      # binding.pry
      
      q = current_user.daily_work_reports 
      q = q.where(project_id: @selected_project) if @selected_project.present?
      q = q.where(current_date: @start_date..@end_date) if date_range_present?
      q.accessible_by(current_ability).order(current_date: :desc)    
    # @daily_work_reports = DailyWorkReport.accessible_by(current_ability)
    # @daily_work_reports = DailyWorkReport.all.order(created_at: :desc)
    end
  end

  def date_range_present?
    @start_date.present? && @end_date.present?
  end

  def set_daily_work_report
    @daily_work_report = DailyWorkReport.find(params[:id])
  end

  def daily_work_report_params
    params.require(:daily_work_report).permit(:current_date, :hours, :status, :user_id, :project_id, :task, :created_by)
  end

end