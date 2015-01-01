class SessionsController < ApplicationController

  def login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
    
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:success] = "Welcome #{authorized_user.username}!"
      redirect_to (:root)
    else
      flash[:error] = "Invalid Username or Password"
      render "login"	
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:success] = "You've been logged out successfully!"
    redirect_to :root
  end
end
