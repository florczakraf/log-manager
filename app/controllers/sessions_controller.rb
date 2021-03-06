class SessionsController < ApplicationController

  def login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
    
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to return_path, success: "Welcome #{authorized_user.username}!"
    else
      flash.now[:error] = "Invalid Username or Password"
      render "login"	
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to :root, success: "You've been logged out successfully!"
  end
end
