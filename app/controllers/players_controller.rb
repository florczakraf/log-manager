class PlayersController < ApplicationController
  before_filter :authenticate_user

  def index
    @guid = params[:guid]
    if @guid
      @players = Player.where("guid LIKE '%#{@guid}%'").paginate(page: params[:page], per_page: 10)
    else
      @players = Player.all.paginate(page: params[:page], per_page: 10)
    end
  end
  
  def show
    id = params[:id]
    @player = Player.find(id)
    @violations = Violation.where("player_id = '#{id}'").order(date: :desc)
    @servers = Server.all
  end
end
