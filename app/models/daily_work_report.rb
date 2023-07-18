class DailyWorkReport < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validate :unique_report_per_day, :on => :create
  validate :number_of_hours
  # validate :validate_user_entry    
  # validate :time_limit, :on => :create
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "current_date", "hours", "id", "project_id", "status", "updated_at", "user_id", "project", "user"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["project", "user"]
  end

  # def time_limit
  #   binding.pry
  #   if user.daily_work_reports.today.count >= 1
  #     errors.add(:base, "Exceeds daily limit")
  #   end
  # end
  def number_of_hours
    if self.hours.present?
      if self.hours > 18
        errors.add(:base, 'You can only add Up to 18 hours a day')
      end
    end
  end

  def unique_report_per_day
    if DailyWorkReport.exists?(user_id: user_id, current_date: current_date)
      # binding.pry
      errors.add(:base, 'You can only add one work report per day.')
      # flash[:notice] = "You can only add one work report per day."
      # flash.alert = 'You can only add one work report per day.'
    end
  end

  # def validate_user_entry
    
  #   # binding.pry
  #   a = User.find(self.user_id)
  #   if not a.company_admin? || a.super_admin?
  #     if self.current_date.present?
  #       date = Date.today
  #       if self.current_date == date
  #         errors.add(:age,'plz provide a valid date of birth here. Age must be greated then 15')
  #       end
  #     end
  #   end
  # end
end
