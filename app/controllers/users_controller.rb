class UsersController < ApplicationController
    def index
        @users = User.order(created_at: :desc)
    end
    def show
        @users = User.find(params[:id])
    end
    def edit
        @users = User.find(params[:id])
    end
    def update        
        # binding.pry
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to users_url, notice: "User was successfully update"
        else 
            render :edit, status: :unprocessable_entity
        end
    end

    private
        def user_params
            params.require(:user).permit(role_ids:[])
        end
end