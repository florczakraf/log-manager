class PlayersController < ApplicationController
  before_filter :save_login_state, :only => [:all]

  def all
    show_per_page = 10
    
    @guid = params[:guid]
    
    if @guid.nil?
      @players = Player.all.paginate(page: params[:page], per_page: show_per_page)
    else
      @players = Player.where("guid LIKE '%#{@guid}%'").paginate(page: params[:page], per_page: show_per_page)
    end
    
  end

  def single
    @id = params[:id]
    
    @player = Player.find(@id)
    
    @violations = Violation.where("player_id = '#{@id}'").order(date: :desc)
    @servers = Server.all
  end
end
