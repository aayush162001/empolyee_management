class UsersController < ApplicationController
    def index
        @users = User.all.page(params[:page])
    end

    def new
        # binding.pry
        @user = User.new
    end
    def create
        binding.pry
        @user = User.new(user_params)
        if @User.save
            redirect_to users_url
        else
            render :new , status: :unprocessable_entity
        end
    end 
    def edit
        @users = User.find(params[:id])
    end
    def update        
        # binding.pry
        @users = User.find(params[:id])
        if @users.update(user_params)
            if current_user.has_any_role? :admin,:"Company Admin"
                redirect_to users_url, notice: "User was successfully update"
            else
                redirect_to root_path, notice: "You update was added successfully."
            end
        else 
            render :edit, status: :unprocessable_entity
        end
    end
    def show
        @users = User.find(params[:id])
    end

    private
        def user_params
            params.require(:user).permit(:email,:password,:name,:role_ids => [])
        end
end
