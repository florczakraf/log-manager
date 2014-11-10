class PlayersController < ApplicationController

  #before_filter :authenticate_user, :only => [:update, :welcome]
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

  def filter
  end

  def ban
  end

  def id
  end
end
