class ApplicationController < ActionController::Base
    before_action :check_login
    helper_method :current_user

    def check_login
        redirect_to new_sign_in_path if !session.include? :user_id
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    end
