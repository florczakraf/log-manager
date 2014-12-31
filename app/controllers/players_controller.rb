class PlayersController < ApplicationController
  def index
    @players = Player.all.paginate(page: params[:page], per_page: 10)
  end
  
  def search
    @guid = params[:guid]
    @players = Player.where("guid LIKE '%#{@guid}%'").paginate(page: params[:page], per_page: 10)
  end
  
  def show
    id = params[:id]
    @player = Player.find(id)
    @violations = Violation.where("player_id = '#{id}'").order(date: :desc)
    @servers = Server.all
  end
end
