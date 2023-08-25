class CheckInOut < ApplicationRecord
  belongs_to :user
  validate :unique_check_in, :on => :create
  def calculate_attendance

    # binding.pry
    if self.user_id != self.created_by
      b = ((self.check_out - self.check_in)/3600).round(2)
      self.work_hours = b
    else
      a = CheckInOut.where(attendance_date:Date.today).where(user_id:user.id)
      b = ((Time.current - a.last.check_in)/3600).round(2)
      self.work_hours = b
    end
  end

  def hours_sum
    # binding.pry
    sum_of_hours = CheckInOut.where(user_id:user.id).where(attendance_date:Date.today).sum("work_hours")
    if sum_of_hours >= 8.00
        if Attendance.exists?(user_id:user.id,attendance_date: Date.today)
            if DailyWorkReport.exists?(user_id: user.id, current_date: Date.today)
                x = user.attendances.where(attendance_date:Date.today)
                # binding.pry
                c = Attendance.find(x.pluck(:id).first)
                # c = a.find{|data| data[:present] == nil }
                # a.update(c[:present] = 1)
#               person = Person.find(2)
                c.update({present: true})
            end
.            else
            Attendance.create(user_id: user.id, attendance_date: Date.today,present:0)
        end
    end
    # c = 0 
    #   a.all.each do |b|
    #     c += ((b.check_out )-(b.check_in))/3600
    #   end

    # self.present = user.daily_work_reports.exists?(user_id: user_id, current_date: attendance_date)
    
  end

  def unique_check_in
    if CheckInOut.where.not(check_in: [nil]).where(check_out: [nil]).exists?(user_id: user_id, attendance_date: Date.today)
      # binding.pry
  #     if Attendance.
      errors.add(:base, 'You are already check in')
  #     # flash[:notice] = "You can only add one work report per day."
      # flash.alert = 'You can only add one work report per day.'
    end
  end

#   def self.scheduled_check_in_mail
#       # if not DailyWorkReport.exists?(user_id: user_id, current_date: current_date)
#       a = CheckInOut.where(attendance_date: Date.yesterday).pluck(:user_id).uniq
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
#   a = CheckInOut.where(attendance_date: Date.today)
  
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
