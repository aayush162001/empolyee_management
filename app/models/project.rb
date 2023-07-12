class Project < ApplicationRecord
    has_many :daily_work_reports
    has_many :users, through: :daily_work_reports
 

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "name", "updated_at"]
    end
    def self.ransackable_associations(auth_object = nil)
        ["daily_work_reports", "users"]
    end
end
