class ServersController < ApplicationController
  
  before_filter :authenticate_user, :is_admin, :only => [:manage, :add, :remove_server]
  
  def all
    @servers = Server.all
  end

  def manage
    @servers = Server.all
    @server = Server.new
  end
  
  def add
    @server = Server.new(server_params)
    if @server.save
      flash[:notice] = "Server added!" 
    else
      flash[:notice] = "Form is invalid!"
    end
    @servers = Server.all
    render "manage"
  end
  
  def remove_server
    @servers = Server.all
    
    @id = params[:id]
    if @id
      server = Server.find(@id)
      server.delete
    end
    flash[:notice] = "#{server.name} has been deleted!"
    render "manage" 
  end
  
  def server_params
    params.require(:server).permit(:id, :name, :ip, :port)
  end
end
