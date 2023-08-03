# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    # binding.pry
    
    if user.super_admin?
      can :manage, :all
    elsif user.company_admin?
      # binding.pry
      can :manage, :all
    elsif user.project_manager?
        # binding.pry     
      can :manage, Project
      can :manage, DailyWorkReport ,user_id: employees_under(user)
      can :manage, DailyWorkReport ,user_id: user.id
      can :manage, Attendance, user_id: user.id
      can :manage, CheckInOut, user_id: user.id
      can :read, Holiday
      can :manage, User,id: user.id
    elsif user.leader?
        # binding.pry     
      can :update, User, id: user.id 
      can :manage, DailyWorkReport ,user_id: employees_under(user)
      # can :manage, DailyWorkReport do |dailyWorkReport|
      #   dailyWorkReport.user_id == user.id
      # end
      can :manage, DailyWorkReport, user_id: user.id
      # can :manage, DailyWorkReport ,user.designation_id < 4, user.department_id
      can :manage, Attendance, user_id: user.id
      can :manage, CheckInOut, user_id: user.id
      can :read, Holiday
      can :manage, User,id: user.id
      # can [:read, :update], Request do |request|
      #   request.client_id == user.id
      # end
    elsif user.employee?
      
      # binding.pry
      can [:read, :update], User, id: user.id
      # can :update, User, id: user.id 
      can :create, DailyWorkReport, user_id: user.id
      can [:read, :update], DailyWorkReport, user_id: user.id 
      can :read, Holiday
      # binding.pry          
      can :create, Attendance, user_id: user.id
      can [:read, :update], Attendance, user_id: user.id
      can :manage, CheckInOut, user_id: user.id
      can :read, Holiday

    else
      can :read, :all
    end


    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
      # return unless user.admin?
      # can :manage, :all
    # 
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  
  
  end

  private

  def employees_under(user)
    
    # binding.pry
    
    # Find employees under the given user using EmailHierarchy table
    a = EmailHierarchy.where("too like ?","%,#{user.id},%").or(EmailHierarchy.where("too like ?","#{user.id},%")).or(EmailHierarchy.where("too like ?","%,#{user.id}"))
    .pluck(:user_id)
    # a = EmailHierarchy.where("to like ?","%#{current_user.id.to_s}%").pluck(:user_id)
    # b = EmailHierarchy.where("cc like ?","%#{current_user.id.to_s}%").pluck(:user_id)
    b = EmailHierarchy.where("cc like ?","%,#{user.id},%").or(EmailHierarchy.where("cc like ?","#{user.id},%")).or(EmailHierarchy.where("cc like ?","%,#{user.id}"))
    .pluck(:user_id)

    # email_hierarchy = DailyWorkReport.where(user_id: (a+b).split(','))
    email_hierarchy = a + b
  end

end
