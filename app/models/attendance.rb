class Attendance < ApplicationRecord
  belongs_to :user
  validate :unique_check_in, :on => :create
  # validate :calculate_attendance, :on => :update
  # validate :present_check
  def calculate_attendance
    
    binding.pry

    a = Attendance.where(attendance_date:Date.today).where(user_id:current_user.id)

    c = 0 
      a.all.each do |b|
        c += ((b.check_out )-(b.check_in))/3600
      end

    self.present = user.daily_work_reports.exists?(user_id: user_id, current_date: attendance_date)
  end

  def present_check
    if user.daily_work_reports.exists?(current_date: attendance_date)
      binding.pry
      if self.work_hours >= 8.00
        self.present = 1
      end
    end
  end

  def unique_check_in
    if Attendance.where.not(check_in: [nil]).where(check_out: [nil]).exists?(user_id: user_id, attendance_date: Date.today)
      binding.pry
  #     if Attendance.
      errors.add(:base, 'You are already check in')
  #     # flash[:notice] = "You can only add one work report per day."
  #     # flash.alert = 'You can only add one work report per day.'
    end
  end


end
