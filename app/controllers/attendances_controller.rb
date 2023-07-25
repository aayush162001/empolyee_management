class AttendancesController < ApplicationController
    
		before_action :set_project, only: [:show, :edit, :update, :destroy]    
    before_action :authenticate_user!
		load_and_authorize_resource
    
		def index
				@attendances = Attendance.where(attendance_date: start_date..end_date).accessible_by(current_ability).order(attendance_date: :desc)
				# @attendances = current_user.attendances.where(date: start_date..end_date)
				@check_out = Attendance.where(attendance_date:Date.today).where(user_id:current_user.id).where.not(check_in: [nil]).where(check_out: [nil])
		end

		def new
				@attendance = Attendance.new
		end

		def create
				
				# binding.pry
				
				@attendance = Attendance.new(attendance_params)
				@attendance.user = current_user
				
				# @attendance.calculate_attendance
		
				if @attendance.save
					redirect_to attendances_path, notice: 'Attendance record created successfully.'
				else
					render :new
				end
		end

		def edit
				
				binding.pry
				
				@attendance = Attendance.where(attendance_date:Date.today).where(user_id:current_user.id).where.not(check_in: [nil]).where(check_out: [nil])
				
				# Find and load the attendance record to be edited
		end
		
		def update
			binding.pry
			# params.fetch(:attendance)[:check_out]
			if @attendance.update(attendance_params)
				# @attendance.work_hours = ((@attendance.check_out - @attendance.check_in) / 3600).round(2)
				# @attendance.save
				# @attendance.present_check
				redirect_to attendances_path, notice: 'Attendance record updated successfully.'
			else
				render :edit
			end
		end

		def check_in
			@attendance = Attendance.new(attendance_date: params[:date], user_id: current_user.id, check_in: Time.current)
			if @attendance.save
				redirect_to attendances_path, notice: 'Check-in successful.'
			else
				redirect_to attendances_path, alert: 'Check-in failed.'
			end
		end
	
		def check_out
			@attendance = Attendance.find(attendance_date[:id])
			@attendance.update(check_out: Time.current)
			
			redirect_to attendances_path, notice: 'Check-out successful.'
		end			
			

		private

		def set_project
			@attendance = Attendance.find(params[:id])
		end
		
		
		def attendance_params
			binding.pry
			params.require(:attendance).permit(:user_id,:attendance_date,:present,:check_in,:check_out,:work_hours)

		end
		

		def start_date
				Date.current.beginning_of_month
		end
		
		def end_date
				Date.current.end_of_month
		end

end
