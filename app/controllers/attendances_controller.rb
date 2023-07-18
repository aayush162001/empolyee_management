class AttendancesController < ApplicationController
    
    
    
    def index
        @attendances = current_user.attendances.where(date: start_date..end_date)

    end

    def new
        @attendance = Attendance.new
    end

    def create
        
        binding.pry
        
        @attendance = Attendance.new(attendance_params)
        @attendance.user = current_user
        @attendance.calculate_attendance
    
        if @attendance.save
          redirect_to attendances_path, notice: 'Attendance record created successfully.'
        else
          render :new
        end
    end

    private

    def attendance_params
        params.require(:attendance).permit(:user_id,:date,:present)
    end
    

    def start_date
        Date.current.beginning_of_month
    end
    
    def end_date
        Date.current.end_of_month
    end

end
