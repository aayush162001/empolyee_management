class Attendance < ApplicationRecord
  belongs_to :user


  def calculate_attendance
    
    binding.pry
    
    self.present = user.daily_work_reports.exists?(user_id: user_id, current_date: current_date)
  end


end
