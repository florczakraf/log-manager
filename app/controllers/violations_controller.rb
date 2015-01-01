class ViolationsController < ApplicationController
  include ViolationsHelper
  def index
    show_per_page = 10
    @servers = Server.all
    @players = Player.all
    
    set_filters
    
    @viol_types = Violation.types
    @violations = Violation.where(type_name: @violation_filter, server_id: @server_filter).order(date: :desc).paginate(page: params[:page], per_page: show_per_page)
  end
  
  def filter
    violation_filter = params[:violation_filter]
    server_filter = params[:server_filter]
    
    if violation_filter
      session[:violation_filter] = violation_filter
    end
    
    if server_filter
      session[:server_filter] = server_filter
    end
    
    redirect_to action: "index"
  end
  
  def show
    @id = params[:id]
    @violation = Violation.find(@id)
    @server = Server.find(@violation.server_id)
    @player = Player.find(@violation.player_id)
  end
end
