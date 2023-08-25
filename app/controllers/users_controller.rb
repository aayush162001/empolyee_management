class UsersController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
        # @users = User.all.page(params[:page])
        @q = User.ransack(params[:q])
        @users = @q.result.page(params[:page]).accessible_by(current_ability)
    end

    def new
        # binding.pry
        @user = User.new
    end
    def show
        @user = User.find(params[:id])
    end
    def create
        # binding.pry
        @user = User.new(user_params)
        if @user.save
            Time.zone = @user.time_zone
            redirect_to users_url
        else
            render :new , status: :unprocessable_entity
        end
    end 
    def edit
    end
    def update        
        # binding.pry
        # @users = User.find(params[:id])
        if current_user.company_admin? || current_user.super_admin?    

            if @users.update(user_params)
                # binding.pry
                redirect_to root_path, notice: "User was successfully update"
            else
                render :edit, status: :unprocessable_entity
            end
        
        elsif current_user.id == params[:id].to_i
            # binding.pry
            if @users.update(user_params)
                # binding.pry
                redirect_to root_path, notice: "You update was added successfully."
            else
                render :edit, status: :unprocessable_entity
            end
        else 
            render :edit, status: :unprocessable_entity
        end
    end
    def active_for_authentication?
        super && is_active
    end
    def soft_delete
        @user = User.find(params[:id])
        @user.soft_delete
    
        redirect_to users_path, notice: 'User was successfully soft deleted.'
    end
    
    private
        def set_user
            @users = User.find(params[:id])
        end
        def user_params
            params[:user][:role] = params[:user][:role].to_i
            params.require(:user).permit(:email,:password,:password_confirmation,:name,:role,:designation_id,:department_id,:dob,:address,:contact,:created_by,:image, :time_zone)
        end
end
