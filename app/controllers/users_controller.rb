class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You signed up successfully" 
    else
      flash[:error] = "Form is invalid"
    end
    render "new"
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin, :activated)
  end
end
