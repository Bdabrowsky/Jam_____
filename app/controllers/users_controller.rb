class UsersController < ApplicationController
  skip_before_action :require_valid_user!
  before_action :reset_session

  def new
    @user = User.create
  end

  def create
    @user = User.create(user_params)

    if @user.save
      session[:user_id] = @user.id

      UserMailer.registration_confirmation(@user).deliver

      flash[:success] =  'You have successfully created an account! Please confirm email.'

      redirect_to root_path
    else
      render :new
    end

  end


  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
