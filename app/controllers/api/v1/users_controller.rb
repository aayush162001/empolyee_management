class Api::V1::UsersController < ApplicationController

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  respond_to :json
  def create
    user = User.find_for_database_authentication(email: session_params[:email])

    if user && user.valid_password?(session_params[:password])
      sign_in user
      render json: { status_code: 200, success: true, message: 'Login successful', data: user, authentication_token: user.authentication_token ,error: nil }
    
    else
      # render json: { error: 'Invalid email or password' }, status: :unauthorized
      render json:         {
        "status_code": 401,
        "success": false,
        data: nil,
        "message": nil,
        "error": "Invalid email or password",
       }, status: :unprocessable_entity
    end
  end

  def destroy
    if user_signed_in?
      sign_out current_user
      render json: { status_code: 200, success: true, message: 'Logout successful', data: nil ,error: nil}
    else
      render json:{
        "status_code": 422,
        "success": false,
        data: nil,
        "message": nil,
        "error": "Log-In Before logout",
       }, status: :unprocessable_entity
    end
  end


  def session_params
      params.permit(:email, :password)
  end

end

