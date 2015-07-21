class UsersController < ApplicationController
  before_filter :authenticate_user, :is_admin, only: [:index, :promote, :demote, :activate, :destroy]
  @show_per_page = 10
  
  def index
    @users = User.all.paginate(page: params[:page], per_page: @show_per_page)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: "You signed up successfully!" 
    else
      render "new"
    end
  end
  
  def promote
    @id = params[:id]

    begin
      user = User.find(@id)
      user.update(admin: true)
      flash[:notice] = "#{user.username} is now admin!"
    rescue
      flash[:alert] = "Something went wrong."
    end
    redirect_to users_path
  end
  
  def demote
    @id = params[:id]
    
    begin
      user = User.find(@id)
      user.update(:admin => false)
      flash[:notice] = "#{user.username} is no longer admin!"
    rescue
      flash[:alert] = "Something went wrong."
    end
    redirect_to users_path
  end
  
  def activate
    @id = params[:id]
    
    begin
      user = User.find(@id)
      user.update(:activated => true)
      flash[:notice] = "#{user.username} has been activated!"
    rescue
      flash[:alert] = "Something went wrong."
    end
    redirect_to users_path
  end
  
  def destroy
    @id = params[:id]
    
    begin
      user = User.find(@id)
      user.delete
      flash[:notice] = "#{user.username} has been deleted!"
    rescue
      flash[:alert] = "Something went wrong."
    end
    redirect_to users_path 
  end
  
  protected
  
  def user_params
    params.require(:user).permit(:id, :username, :email, :password, :password_confirmation, :admin, :activated)
  end
end
