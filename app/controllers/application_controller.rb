class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception 
  before_filter :set_variables
  before_filter :save_login_state
  add_flash_types :error, :success
  
  def set_variables
    @last_update = Setting.first.last_update
  end
  
  private
  
  def is_admin
    if @current_user
      if @current_user.admin
        return true
      else
        flash[:error] = "You are not an admin."
        redirect_to :root
      end
    else
      redirect_to login_path, notice: "You have to log in to admin account."
      return false
    end
  end
  
  def authenticate_user
    if session[:user_id]
      current_user = User.find(session[:user_id])
      if current_user && current_user.activated
        @current_user = current_user
        return true
      else
        redirect_to :root, alert: "Your account has not been activated"
      end
    else
      session[:return_to] = request.path
      redirect_to login_path, notice: "You have to log in!"
      return false
    end
  end
  
  def save_login_state
    if session[:user_id]
      @current_user = User.find(session[:user_id])
      return false
    else
      return true
    end
  end
  
  def return_path
    session[:return_to] || root_path
  end
end
