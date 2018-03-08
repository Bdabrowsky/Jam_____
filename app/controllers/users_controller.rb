class UsersController < ApplicationController
  skip_before_action :require_valid_user!
  before_action :reset_session

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      UserMailer.registration_confirmation(@user).deliver

      flash[:success] =  'You have successfully created an account! Please confirm email.'

      redirect_to root_path
    else
      render :new
    end

  end

    def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to signin_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
    end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
