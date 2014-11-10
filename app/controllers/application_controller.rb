class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception 
  
  before_filter :save_login_state, :only => [:new, :create]
  
  protected
  def authenticate_user
    if session[:user_id]
      current_user = User.find session[:user_id]
      
      if current_user.activated
        @current_user = current_user
        return true
      else
        flash[:error] = "Your account has not been activated yet."
        redirect_to :root
      end
    else
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    end
  end
  
  def save_login_state
    if session[:user_id]
      @current_user = User.find session[:user_id]
      return false
    else
      return true
    end
  end
end
