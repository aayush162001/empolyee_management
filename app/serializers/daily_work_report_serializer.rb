class DailyWorkReportSerializer < ActiveModel::Serializer
  attributes :user_id, :current_date, :project_id, :task, :status, :hours
end
