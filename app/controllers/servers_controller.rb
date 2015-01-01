class ServersController < ApplicationController
  
  before_filter :authenticate_user, :is_admin, :only => [:manage, :create, :destroy]
  
  def index
    @servers = Server.all
  end

  def manage
    @servers = Server.all
    @server = Server.new
  end
  
  def create
    @server = Server.new(server_params)
    if @server.save
      flash[:notice] = "Server added!" 
    else
      flash[:notice] = "Form is invalid!"
    end
    @servers = Server.all
    render "manage"
  end
  
  def destroy
    @servers = Server.all
    
    @id = params[:id]
    if @id
      begin
        server = Server.find(@id)
        server.delete
        flash[:notice] = "#{server.name} has been deleted!"
      rescue
        flash[:notice] = "Something went wrong."
      end
    end
    render "manage"
  end
  
  protected
  
  def server_params
    params.require(:server).permit(:id, :name, :ip, :port)
  end
end
