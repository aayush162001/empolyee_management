class User < ApplicationRecord
  has_and_belongs_to_many :roles
  has_many :projects, through: :daily_work_reports
  has_many :daily_work_reports
  # paginates_per 2 
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  after_create :assign_default_role

  validate :must_have_a_role, on: :update

  private

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, 'must have at least 1 role')
    end
  end


end
