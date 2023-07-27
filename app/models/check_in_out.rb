class CheckInOut < ApplicationRecord
    belongs_to :user
    validate :unique_check_in, :on => :create
    def calculate_attendance

        binding.pry

        a = CheckInOut.where(attendance_date:Date.today).where(user_id:user.id)
        b = ((Time.current - a.last.check_in)/3600).round(2)
        self.work_hours = b

    end

    def hours_sum
        sum_of_hours = CheckInOut.where(user_id:user.id).where(attendance_date:Date.today).sum("work_hours")
        if sum_of_hours >= 8.00
            if Attendance.exists?(user_id:user.id,attendance_date: Date.today)
                x = user.attendances.where(attendance_date:Date.today)
                    binding.pry
                    c = Attendance.find(x.pluck(:id).first)
                    # c = a.find{|data| data[:present] == nil }
                    # a.update(c[:present] = 1)
      #               person = Person.find(2)
                    c.update({present: true})
            else
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
          binding.pry
      #     if Attendance.
          errors.add(:base, 'You are already check in')
      #     # flash[:notice] = "You can only add one work report per day."
      #     # flash.alert = 'You can only add one work report per day.'
        end
    end



end
