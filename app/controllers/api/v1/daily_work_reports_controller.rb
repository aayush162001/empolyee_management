class Api::V1::DailyWorkReportsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    def index
        @daily_work_reports = DailyWorkReport.accessible_by(current_ability)
        render json: @daily_work_reports, each_serializer: DailyWorkReportSerializer
        # render json: {status_code: 200, success: true, message: 'successful can see daily_work_reports', data: daily_work_reports, error: nil }
    end
end
