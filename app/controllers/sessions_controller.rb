class SessionsController < ApplicationController
  skip_before_action :require_valid_user!, except: [:destroy]

  def new
  end

  def create
    reset_session
    @user = User.find_by(email: session_params[:email])

    if @user && @user.authenticate(session_params[:password])     
        session[:user_id] = @user.id   
        redirect_to dashboard_path       
    else
      flash[:error] = 'Invalid email or password!'
      redirect_to login_path
    end
  end

  def destroy
    reset_session
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
