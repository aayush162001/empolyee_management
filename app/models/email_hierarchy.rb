class EmailHierarchy < ApplicationRecord
  has_and_belongs_to_many :user
  # validates :user_id, presence: true
end
