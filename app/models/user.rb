class User < ApplicationRecord
  # has_and_belongs_to_many :roles
  enum role: [:employee, :leader, :project_manager, :company_admin, :super_admin]
  # enum department: [:ror, :fullstack , :python, :admin, :ceo]

  has_many :projects, through: :daily_work_reports
  has_many :daily_work_reports
  has_one :email_hierarchy
  has_many :attendances
  has_many :check_in_out
  belongs_to :designation
  has_one_attached :image
  # validate :custom_email_validation


  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :name,  length: { minimum: 3, maximum: 50  }
  # validates :name, format: { with: /\A[a-zA-Z]+\z/, message: 'only letters are allowed'}
  after_initialize :set_default_role, if: :new_record?
  # after_initialize :set_default_role, :set_default_department, if: :new_record?
  before_save :ensure_authentication_token
  paginates_per 15
  # rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :token_authenticatable, :validatable, :session_limitable

  # after_create :assign_default_role

  # validate :must_have_a_role, on: :update

  private

  # def assign_default_role
  #   self.add_role(:newuser) if self.roles.blank?
  # end

  def set_default_role
    self.role ||= :employee
  end
  # def set_default_department
  #   self.department ||= :ror
  # end

  # def must_have_a_role
  #   unless roles.any?
  #     errors.add(:roles, 'must have at least 1 role')
  #   end
  # end
  def custom_email_validation
    
    binding.pry
    
    if email.blank?
      errors.add(:email, "Email can't be blank")
    elsif !email.include?('@')
      errors.add(:email, "Invalid email format")
    end
  end

end
