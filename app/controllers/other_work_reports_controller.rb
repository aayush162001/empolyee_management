class OtherWorkReportsController < ApplicationController
  before_action :set_other_work_report, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!
  # load_and_authorize_resource

  # GET /other_work_reports or /other_work_reports.json
  def index
    a = EmailHierarchy.where("too like ?","%,#{current_user.id},%").or(EmailHierarchy.where("too like ?","#{current_user.id},%")).or(EmailHierarchy.where("too like ?","%,#{current_user.id}"))
    .pluck(:user_id)
    # a = EmailHierarchy.where("to like ?","%#{current_user.id.to_s}%").pluck(:user_id)
    # b = EmailHierarchy.where("cc like ?","%#{current_user.id.to_s}%").pluck(:user_id)
    b = EmailHierarchy.where("cc like ?","%,#{current_user.id},%").or(EmailHierarchy.where("cc like ?","#{current_user.id},%")).or(EmailHierarchy.where("cc like ?","%,#{current_user.id}"))
    .pluck(:user_id)
    @q = DailyWorkReport.where(user_id: (a+b).split(',')).ransack(params[:q])
    @other_work_reports = @q.result(distinct: true).accessible_by(current_ability).order(current_date: :desc)
  # end

  end

  # GET /other_work_reports/1 or /other_work_reports/1.json
  def show
  end

  # GET /other_work_reports/new
  def new
    @other_work_report = DailyWorkReport.new
  end

  # GET /other_work_reports/1/edit
  def edit
  end

  # POST /other_work_reports or /other_work_reports.json
  def create
    binding.pry

    @other_work_report = DailyWorkReport.new(other_work_report_params)

    # @daily_work_report = DailyWorkReport.new(daily_work_report_params)
    binding.pry

      if not current_user.id == params[:daily_work_report][:user_id].to_i
      # @daily_work_report.current_date = Time.now
        if Project.exists?(params[:daily_work_report][:project_id])
          if @other_work_report.save
            # binding.pry
            if not current_user.email_hierarchy == nil
              DailyWorkReportMailer.new_work_report_notification(@daily_work_report).deliver_now
              redirect_to other_work_reports_path, notice: 'Daily work report was successfully created.'
            else
              redirect_to other_work_reports_path, notice: 'Daily work report was successfully created.'
            end
          else
            render :new, status: :unprocessable_entity
          end
        else
          redirect_to new_other_work_report_path, alert: 'Invalid project selection.'
        end
      else
        redirect_to new_other_work_report_path, alert: ' yesterday.'
      end
  end

  # PATCH/PUT /other_work_reports/1 or /other_work_reports/1.json
  def update
    if @other_work_report.update(other_work_report_params)
      redirect_to @other_work_report, notice: 'Daily work report was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /other_work_reports/1 or /other_work_reports/1.json
  def destroy
    @other_work_report.destroy

    respond_to do |format|
      format.html { redirect_to other_work_reports_url, notice: "Other work report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_other_work_report
      @other_work_report = DailyWorkReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.

    def other_work_report_params
      
      binding.pry
      
      params.require(:daily_work_report).permit(:current_date, :hours, :status, :user_id, :project_id)
    end
end
