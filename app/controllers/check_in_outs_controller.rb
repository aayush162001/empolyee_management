class CheckInOutsController < ApplicationController
    # before_action :set_project, only: [:show, :edit, :update, :destroy]    
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
			# @attendances = Attendance.where(attendance_date: start_date..end_date).accessible_by(current_ability).order(attendance_date: :desc)
			category = (params[:category] or (params[:q][:category] if params[:q].present?))
			# binding.pry
			@check_in_outs = fetch_products(category)
			# @check_in_outs = current_user.check_in_out.order(attendance_date: :desc)
			@check_out = CheckInOut.where(attendance_date:Date.today).where(user_id:current_user.id).where.not(check_in: [nil]).where(check_out: [nil])
	end

	def new
			@check_in_out = CheckInOut.new
	end

	def create

			if params[:check_in_out].present?
				if params[:check_in_out][:category] == "other_work_reports"
					@check_in_out = CheckInOut.new(check_in_out_params)
					
					@check_in_out.work_hours = @check_in_out.calculate_attendance
					@check_in_out.hours_sum
					if @check_in_out.save

						redirect_to check_in_outs_path(category: "other_work_reports"), notice: 'Attendance record created successfully.'
					
					end
				end
			else
				@check_in_out = CheckInOut.new(user_id: current_user.id, attendance_date: Date.current, check_in: Time.current,created_by: current_user.id)
				@check_in_out.user = current_user
				if @check_in_out.save

					redirect_to check_in_outs_path, notice: 'Attendance record created successfully.'
				
				end
			end
			
			# @attendance.calculate_attendance
	

	end

	def create_other
		pass
	end

	def edit
			
			# binding.pry
			
			@check_in_out = CheckInOut.where(attendance_date:Date.today).where(user_id:current_user.id).where.not(check_in: [nil]).where(check_out: [nil])
			
			# Find and load the attendance record to be edited
	end
	
	def update
		# binding.pry
		# params.fetch(:attendance)[:check_out]
		# if @attendance.update(attendance_params)
		@check_in_out = CheckInOut.find_by(user_id: current_user.id, attendance_date: Date.current,check_out: [nil])
    	
		# @attendance =  Attendance.where(user_id: current_user.id, attendance_date: Date.current).where(check_out: [nil])
		
		if @check_in_out.update(check_out: Time.current, work_hours: @check_in_out.calculate_attendance)
			@check_in_out.hours_sum
			# @attendance.work_hours = ((@attendance.check_out - @attendance.check_in) / 3600).round(2)
			# @attendance.save
			# @attendance.present_check
			redirect_to check_in_outs_path, notice: 'Attendance record updated successfully.'
		else
			render :edit
		end
	end
	def other_in_out
		# if user_signed_in?  
		  

		  
		  a = EmailHierarchy.where("too like ?","%,#{current_user.id},%").or(EmailHierarchy.where("too like ?","#{current_user.id},%")).or(EmailHierarchy.where("too like ?","%,#{current_user.id}")).or(EmailHierarchy.where("cc like ?","#{current_user.id}"))
		  .pluck(:user_id)
		  # a = EmailHierarchy.where("to like ?","%#{current_user.id.to_s}%").pluck(:user_id)
		  # b = EmailHierarchy.where("cc like ?","%#{current_user.id.to_s}%").pluck(:user_id)
		  b = EmailHierarchy.where("cc like ?","%,#{current_user.id},%").or(EmailHierarchy.where("cc like ?","#{current_user.id},%")).or(EmailHierarchy.where("cc like ?","%,#{current_user.id}")).or(EmailHierarchy.where("cc like ?","#{current_user.id}")).pluck(:user_id)
	
		@check_in_outs = Attendance.where(user_id: (a+b).split(',')).order(current_date: :desc)
		# end
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

	# def set_project
	# 	@check_in_out = CheckInOut.find(params[:id])
	# end
	
	
	def check_in_out_params
		if params[:check_in_out].present?
			params.require(:check_in_out).permit(:user_id,:attendance_date,:check_in,:check_out,:work_hours,:created_by)
		end
	end
	def fetch_products(category)
		# binding.pry
		if category == "other_work_reports"
		  
		  # binding.pry
		  
		  a = EmailHierarchy.where("too like ?","%,#{current_user.id},%").or(EmailHierarchy.where("too like ?","#{current_user.id},%")).or(EmailHierarchy.where("too like ?","%,#{current_user.id}")).or(EmailHierarchy.where("cc like ?","#{current_user.id}"))
		  .pluck(:user_id)
		  # a = EmailHierarchy.where("to like ?","%#{current_user.id.to_s}%").pluck(:user_id)
		  # b = EmailHierarchy.where("cc like ?","%#{current_user.id.to_s}%").pluck(:user_id)
		  b = EmailHierarchy.where("cc like ?","%,#{current_user.id},%").or(EmailHierarchy.where("cc like ?","#{current_user.id},%")).or(EmailHierarchy.where("cc like ?","%,#{current_user.id}")).or(EmailHierarchy.where("cc like ?","#{current_user.id}")).pluck(:user_id)
		  @check_in_outs = CheckInOut.where(user_id: (a+b).split(',')).accessible_by(current_ability).order(current_date: :desc)
		  # @daily_work_reports = @qs.result(distinct: true).accessible_by(current_ability).order(current_date: :desc)
		#   @q = DailyWorkReport.where(user_id: (a+b)).ransack(params[:q])
		#   @q.result(distinct: true).accessible_by(current_ability).order(current_date: :desc)
		# end
		else
		  
		  # binding.pry
		  
		  @check_in_outs = current_user.check_in_out.accessible_by(current_ability).order(attendance_date: :desc)
		#   @q.result(distinct: true).accessible_by(current_ability).order(current_date: :desc)
		# @daily_work_reports = DailyWorkReport.accessible_by(current_ability)
		# @daily_work_reports = DailyWorkReport.all.order(created_at: :desc)
		end
	end	

	def start_date
		Date.current.beginning_of_month
	end
	
	def end_date
		Date.current.end_of_month
	end

end
