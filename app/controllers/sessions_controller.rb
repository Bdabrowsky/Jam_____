class SessionsController < ApplicationController
  skip_before_action :require_valid_user!, except: [:destroy]

  def new
  end

  def create
    reset_session
    @user = User.find_by(email: session_params[:email])

    if @user && @user.authenticate(session_params[:password])
      if @user.email_confirmed
          sign_in user
          redirect_back_or user
      else
        flash.now[:error] = 'Please activate your account by following the 
        instructions in the account confirmation email you received to proceed'
        render 'new'
      end
        session[:user_id] = @user.id          
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
