class Attendance < ApplicationRecord
  belongs_to :user
  validate :unique_check_in, :on => :create
  # validate :calculate_attendance, :on => :update
  # validate :present_check
  # after_update :present_check
  def calculate_attendance
    

    a = Attendance.where(attendance_date:Date.today).where(user_id:user.id)
    b = ((Time.current - a[0].check_in)/3600).round(2)
    self.work_hours = b
    # c = 0 
    #   a.all.each do |b|
    #     c += ((b.check_out )-(b.creck_in))/3600
    #   end

    # self.present = user.daily_work\'njnzxsgdll.vfda.bf[b[_reports.exists?(user_id: user_id, current_date: attendance_date)
    
  end

  # def present_check
  #   binding.pry
  #   if user.daily_work_reports.exists?(current_date: attendance_date)
  #     binding.pry
  #     if self.work_hours >= 8.00
  #       self.present = 1
  #     end
  #   # else
  #     # flash[:notice] = "Add Your Work Report"
  #   end
  # end

  def unique_check_in
    if Attendance.where.not(check_in: [nil]).where(check_out: [nil]).exists?(user_id: user_id, attendance_date: Date.today)

  #     if Attendance.
      errors.add(:base, 'You are already check in')
  #     # flash[:notice] = "You can only add one work report per day."
  #     # flash.alert = 'You can only add one work report per day.'
    end
  end

  # def self.scheduled_check_in_mail
  #       # if not DailyWorkReport.exists?(user_id: user_id, current_date: current_date)
  #       a = Attendance.where(attendance_date: Date.yesterday).pluck(:user_id).uniq
  #       # a =DailyWorkReport.where(current_date: Date.yesterday).pluck(:user_id)
  #       x = DailyWorkReport.where.not(user_id:a).where(current_date:Date.yesterday).pluck(:user_id)
  #       @mail_to = User.where(id:x).ids
  #       # @user.each do |u|
  #       #   UsersMailer.weekly_mail(u.email).deliver
  #       #   end
  #       @mail_to.each do |u|
  #         AttendanceMailer.check_in_mail(u).deliver_now
  #       end
  # end

  # def self.scheduled_check_out_mail
  #   # if not DailyWorkReport.exists?(user_id: user_id, current_date: current_date)
  #   a = Attendance.where(attendance_date: Date.yesterday)
    
  #   # a =DailyWorkReport.where(current_date: Date.yesterday).pluck(:user_id)
  #   x = a.where.not(check_in: [nil]).where(check_out: [nil]).pluck(:user_id)
  #   @mail_to = User.where(id:x).ids
  #   # @user.each do |u|
  #   #   UsersMailer.weekly_mail(u.email).deliver
  #   #   end
  #   @mail_to.each do |u|
  #     AttendanceMailer.check_out_mail(u).deliver_now
  #   end
  # end

end
