class RegistrationsController < Devise::RegistrationsController
    before_action :authenticate_user!, :redirect_unless_admin,  only: [:new, :create]
    skip_before_action :require_no_authentication
  
    private
    def redirect_unless_admin
        if user_signed_in?
            if not current_user.company_admin? || current_user.super_admin?
                flash[:error] = "Only admins can do that"
                redirect_to root_path
            end
        elsif not user_signed_in?
            redirect_to root_path
        end
    end
  
    def sign_up(resource_name, resource)
      true
    end
  end
  
  
