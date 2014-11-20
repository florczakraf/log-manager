class ViolationsController < ApplicationController

  def all
    show_per_page = 10
    @servers = Server.all
    @players = Player.all
    
    @viol_types = ["MD5TOOL", "CVAR", "GAMEHACK", "DUPGUID", "DUPNAME", "BADNAME",
      "COMFAIL", "GAME INTEGRITY", "AUTO-UPDATE FAILURE", "NAME SPAM"]
    
    violation_filter = params[:violation_filter]
    server_filter = params[:server_filter]
    
    if violation_filter
      session[:violation_filter] = violation_filter
    end
    
    if server_filter
      session[:server_filter] = server_filter
    end
    
    @violation_filter = session[:violation_filter]
    if @violation_filter.nil?
      session[:violation_filter] = @viol_types
      @violation_filter = @viol_types
    end

    @server_filter = session[:server_filter]
    if @server_filter.nil?
      @server_filter = []
      @servers.each { |srv| @server_filter.push(srv.id) }
      session[:server] = @server_filter
    end
    
    @violations = Violation.where(type_name: @violation_filter, server_id: @server_filter).order(date: :desc).paginate(page: params[:page], per_page: show_per_page)
  end
  
  def single
    @id = params[:id]
    @violation = Violation.find(@id)
    @server = Server.find(@violation.server_id)
    @player = Player.find(@violation.player_id)
  end
end
