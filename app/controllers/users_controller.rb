class UsersController < ApplicationController
  before_filter :authenticate_user, :is_admin, :only => [:manage, :make_admin, :remove_admin, :activate]
  @show_per_page = 10
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You signed up successfully!" 
    else
      flash[:error] = "Form is invalid!"
    end
    render "new"
  end
  
  def manage
    
    @users = User.all.paginate(page: params[:page], per_page: @show_per_page)
  end
  
  def make_admin
    @users = User.all.paginate(page: params[:page], per_page: @show_per_page)
  
    @id = params[:id]
    if @id
      user = User.find(@id)
      user.update(:admin => true)
    end
    flash[:notice] = "#{user.username} is now admin!"
    render "manage"
  end
  
  def remove_admin
    @users = User.all.paginate(page: params[:page], per_page: @show_per_page)
    
    @id = params[:id]
    if @id
      user = User.find(@id)
      user.update(:admin => false)
    end
    flash[:notice] = "#{user.username} is no longer admin!"
    render "manage"
  end
  
  def activate
    @users = User.all.paginate(page: params[:page], per_page: @show_per_page)
    
    @id = params[:id]
    if @id
      user = User.find(@id)
      user.update(:activated => true)
    end
    flash[:notice] = "#{user.username} has been activated!"
    render "manage" 
  end
  
  def remove_user
    @users = User.all.paginate(page: params[:page], per_page: @show_per_page)
    
    @id = params[:id]
    if @id
      user = User.find(@id)
      user.delete
    end
    flash[:notice] = "#{user.username} has been deleted!"
    render "manage" 
  end
  
  def user_params
    params.require(:user).permit(:id, :username, :email, :password, :password_confirmation, :admin, :activated)
  end
end
