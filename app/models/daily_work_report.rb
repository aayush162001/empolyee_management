class DailyWorkReport < ApplicationRecord
  belongs_to :user
  belongs_to :project
      
    
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "current_date", "hours", "id", "project_id", "status", "updated_at", "user_id", "project", "user"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["project", "user"]
  end
end
