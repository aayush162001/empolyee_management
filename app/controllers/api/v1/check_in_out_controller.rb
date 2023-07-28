class Api::V1::CheckInOutController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    skip_before_action :verify_authenticity_token
    def create

        check_in_out = CheckInOut.new(user_id: current_user.id, attendance_date: Date.current, check_in: Time.current)
        check_in_out.user = current_user
        
        # @attendance.calculate_attendance

        if check_in_out.save
            render json: { "status_code": 200, "success": true, message: 'Check In successful', data: check_in_out }
            # redirect_to check_in_outs_path, notice: 'Attendance record created successfully.'
        else
            render json: { error: 'Invalid check In' }, status: :unprocessable_entity
        end
        # {
        #     "status_code": 422,
        #     "success": false,
        #     "data": null,
        #     "message": "Team レコードが見つからない",
        #     "error": null
        #    }
        
    end

    def update
        check_in_out = CheckInOut.find_by(user_id: current_user.id, attendance_date: Date.current,check_out: [nil])
    	
		# @attendance =  Attendance.where(user_id: current_user.id, attendance_date: Date.current).where(check_out: [nil])
		
		if check_in_out.update(check_out: Time.current, work_hours: check_in_out.calculate_attendance)
			check_in_out.hours_sum
			# @attendance.work_hours = ((@attendance.check_out - @attendance.check_in) / 3600).round(2)
			# @attendance.save
			# @attendance.present_check
			# redirect_to check_in_outs_path, notice: 'Attendance record updated successfully.'
            render json: { message: 'Check Out successful', data: check_in_out }
		else
			render json: { error: 'Invalid check Out' }, status: :unprocessable_entity
		end
    end
end
