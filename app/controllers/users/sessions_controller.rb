# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by_email(params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      if user.is_active
        super # Proceed with the default Devise sign-in process
      else
        flash[:error] = "Your account is currently inactive."
        redirect_to new_user_session_path
      end
    else
      flash[:error] = "Invalid email or password."
      redirect_to new_user_session_path
    end
  end

  # def active_for_authentication?
  #   super && is_active
  # end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
