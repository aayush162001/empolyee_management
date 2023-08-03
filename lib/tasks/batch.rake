namespace :batch do
  desc "Send out batch messages"
  
  task scheduled_check_in_mail: :environment do
    # puts "Hello User! Welcome to the rake world!"
    # def scheduled_check_in_mail
    # binding.pry
        
        # if not DailyWorkReport.exists?(user_id: user_id, current_date: current_date)
        a = CheckInOut.where(attendance_date: Date.today).pluck(:user_id).uniq
        # a =DailyWorkReport.where(current_date: Date.yesterday).pluck(:user_id)
        x = DailyWorkReport.where.not(user_id:a).where(current_date:Date.today).pluck(:user_id)
        @mail_to = User.where(id:x).ids
        # @user.each do |u|
        #   UsersMailer.weekly_mail(u.email).deliver
        #   end
        @mail_to.each do |u|
          AttendanceMailer.check_in_mail(u).deliver_now
        end
  end
    
  task scheduled_check_out_mail: :environment do
    a = CheckInOut.where(attendance_date: Date.yesterday)
    
    # a =DailyWorkReport.where(current_date: Date.yesterday).pluck(:user_id)
    x = a.where.not(check_in: [nil]).where(check_out: [nil]).pluck(:user_id)
    @mail_to = User.where(id:x).ids
    # @user.each do |u|
    #   UsersMailer.weekly_mail(u.email).deliver
    #   end
    @mail_to.each do |u|
      AttendanceMailer.check_out_mail(u).deliver_now
    end
  end

  task scheduled_report_mail: :environment do
   
    # binding.pry
    # puts "Hey "
    # if not DailyWorkReport.exists?(user_id: user_id, current_date: current_date)
    a = DailyWorkReport.where(current_date: Date.yesterday).pluck(:user_id)
    # a =DailyWorkReport.where(current_date: Date.yesterday).pluck(:user_id)
    @mail_to = User.where.not(id:a).ids
    # @user.each do |u|
    #   UsersMailer.weekly_mail(u.email).deliver
    #   end
    @mail_to.each do |u|
        DailyWorkReportMailer.scheduled_report_mail(u).deliver_now
    end

  end
end