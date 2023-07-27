class CheckInOutsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :update, :destroy]    
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
			# @attendances = Attendance.where(attendance_date: start_date..end_date).accessible_by(current_ability).order(attendance_date: :desc)
			@check_in_outs = current_user.check_in_out.where(attendance_date: start_date..end_date)
			@check_out = CheckInOut.where(attendance_date:Date.today).where(user_id:current_user.id).where.not(check_in: [nil]).where(check_out: [nil])
	end
	def check_attendance
		# if user_signed_in?  
		  
		  binding.pry
		  
		a = EmailHierarchy.where("too like ?","%,#{current_user.id},%").or(EmailHierarchy.where("too like ?","#{current_user.id},%")).or(EmailHierarchy.where("too like ?","%,#{current_user.id}")).pluck(:user_id)
		# a = EmailHierarchy.where("to like ?","%#{current_user.id.to_s}%").pluck(:user_id)
		# b = EmailHierarchy.where("cc like ?","%#{current_user.id.to_s}%").pluck(:user_id)
		b = EmailHierarchy.where("cc like ?","%,#{current_user.id},%").or(EmailHierarchy.where("cc like ?","#{current_user.id},%")).or(EmailHierarchy.where("cc like ?","%,#{current_user.id}")).pluck(:user_id)
		@check_in_out = CheckInOut.where(user_id: (a+b).split(',')).order(current_date: :desc)
		# end
	  end
	def new
			@check_in_out = CheckInOut.new
	end

	def create
			
			# binding.pry
			
			@check_in_out = CheckInOut.new(user_id: current_user.id, attendance_date: Date.current, check_in: Time.current)
			@check_in_out.user = current_user
			
			# @attendance.calculate_attendance
	
			if @check_in_out.save
				redirect_to check_in_outs_path, notice: 'Attendance record created successfully.'
			else
				render :check_in_outs_path, status: :unprocessable_entity
			end
	end

	def edit
			
			binding.pry
			
			@check_in_out = CheckInOut.where(attendance_date:Date.today).where(user_id:current_user.id).where.not(check_in: [nil]).where(check_out: [nil])
			
			# Find and load the attendance record to be edited
	end
	
	def update
		binding.pry
		# params.fetch(:attendance)[:check_out]
		# if @attendance.update(attendance_params)
		@check_in_out = CheckInOut.find_by(user_id: current_user.id, attendance_date: Date.current,check_out: [nil])
    	
		# @attendance =  Attendance.where(user_id: current_user.id, attendance_date: Date.current).where(check_out: [nil])
		
		if @check_in_out.update(check_out: Time.current, work_hours: @check_in_out.calculate_attendance)
			# @attendance.work_hours = ((@attendance.check_out - @attendance.check_in) / 3600).round(2)
			# @attendance.save
			# @attendance.present_check
			redirect_to check_in_outs_path, notice: 'Attendance record updated successfully.'
		else
			render :edit
		end
	end

	def check_in
		@check_in_out = CheckInOut.new(attendance_date: params[:date], user_id: current_user.id, check_in: Time.current)
		if @attendance.save
			redirect_to attendances_path, notice: 'Check-in successful.'
		else
			redirect_to attendances_path, alert: 'Check-in failed.'
		end
	end

	def check_out
		@check_in_out = CheckInOut.find(attendance_date[:id])
		@check_in_out.update(check_out: Time.current)
		
		redirect_to attendances_path, notice: 'Check-out successful.'
	end			
		

	private

	def set_project
		@check_in_out = CheckInOut.find(params[:id])
	end
	
	
	# def attendance_params
	# 	binding.pry
	# 	params.require(:attendance).permit(:user_id,:attendance_date,:present,:check_in,:check_out,:work_hours)

	# end
	

	def start_date
			Date.current.beginning_of_month
	end
	
	def end_date
			Date.current.end_of_month
	end

end
