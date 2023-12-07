class SessionsController < ApplicationController
  skip_before_action :check_login, only: [:create, :new]

  def new
  end

  def create
    session_params = params.permit(:email, :password)
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to tickets_url
    else
      flash[:notice] = "Login is invalid!"
      redirect_to new_sign_in_path
    end
  end

  def destroy
    reset_session
    redirect_to new_sign_in_path, notice: "You have been logged out."
  end

end
