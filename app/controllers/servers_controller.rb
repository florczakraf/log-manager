class ServersController < ApplicationController
  before_filter :authenticate_user, :is_admin, only: [:manage, :new, :create, :destroy, :edit, :update]
  
  def index
    @servers = Server.all
  end

  def manage
    @servers = Server.all
  end
  
  def new
    @server = Server.new
  end
  
  def create
    @server = Server.new(server_params)
    if @server.save
      redirect_to manage_servers_path, success: "Server added!" 
    else
      render "new"
    end
  end
  
  def destroy
    server = Server.find(params[:id])
    if server
      server.delete
      redirect_to manage_servers_path, success: "#{server.name} has been deleted!"
    else
      redirect_to manage_servers_path, error: "Something went wrong."
    end
  end
  
  def edit
    @server = Server.find(params[:id])
  end

  def update
    @server = Server.find(params[:id])
    if @server.update(server_params)
      redirect_to manage_servers_path
    else
      render "edit"
    end
  end
  
  protected
  
  def server_params
    params.require(:server).permit(:id, :name, :ip, :port)
  end
end
