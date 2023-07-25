class Api::V1::AttendanceController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    def index
        # Retrieve daily work reports from the database (you can customize this part based on your data model)
        attendance = Attendance.accessible_by(current_ability)
    
        # Return the daily work reports as JSON response
        render json: attendance
    end
end
