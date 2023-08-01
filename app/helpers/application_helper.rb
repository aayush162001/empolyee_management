module ApplicationHelper
    def working_days_count_in_month(date)
        first_day = date.beginning_of_month
        last_day = date.end_of_month
    
        holidays = Holiday.where(attendance_date: first_day..last_day)
        working_days = (first_day..last_day).count { |day| (1..5).include?(day.wday) && !holidays.pluck(:attendance_date).include?(day) }
    
        working_days
    end
end
