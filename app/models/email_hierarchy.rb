class EmailHierarchy < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  # def to_emails
  #   User.find(user_id).email
  # end
    
  # def cc_emails
  #   User.where
  # end

end
