class Api::V1::UsersController < ApplicationController
#     skip_before_action :verify_authenticity_token
#     before_action :authenticate_user!, except: :create
#     respond_to :json
  
#   # /api/v1/sign_in.json
#   def create
#     user = User.find_by(email: params[:email])
#     if user&.valid_password?(params[:password])
#       sign_in user
#       render json: { message: 'Successfully logged in.', user: user }
#     else
#       render json: { error: 'Invalid email or password.' }, status: :unauthorized
#     end
#   end

#   # /api/v1/sign_out.json
#   def destroy
#     sign_out current_user
#     render json: { message: 'Successfully logged out.' }
#   end
  
# #   def failure
# #     render :json => {:success => false, :errors => ["Login Failed"]}, status: 401
# #   end
# # protected
# #   def auth_options
# #     { :scope => resource_name, :recall => "#{controller_path}#failure" }
# #   end
protect_from_forgery with: :null_session
skip_before_action :verify_authenticity_token
respond_to :json
def create
  user = User.find_for_database_authentication(email: session_params[:email])

  if user && user.valid_password?(session_params[:password])
    sign_in user
    render json: { message: 'Login successful', user: user, authentication_token: user.authentication_token }
  else
    render json: { error: 'Invalid email or password' }, status: :unauthorized
  end
end

def destroy
    sign_out current_user
    render json: { message: 'Logout successful' }
end


def session_params
    params.permit(:email, :password)
  end

end

