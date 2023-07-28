class ApplicationController < ActionController::Base

    rescue_from CanCan::AccessDenied do |exception|
        render json: { waring: exception, status: 'authorization_failed'}
    end
    # rescue_from 
end
