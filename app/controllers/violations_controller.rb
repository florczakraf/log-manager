class ViolationsController < ApplicationController
  def index
    show_per_page = 10
    
    @type_name = params[:type_name]
    
    if @type_name.nil? || @type_name == "ALL"
      @violations = Violation.order(date: :desc).all.paginate(page: params[:page], per_page: show_per_page)
    elsif @type_name != "ALL"
      @violations = Violation.where("type_name LIKE '#{@type_name}'").order(date: :desc).paginate(page: params[:page], per_page: show_per_page)
    end
    
    @servers = Server.all
    @players = Player.all
    
    @viol_types = [
        ["ALL", "ALL"], ["MD5TOOL", "MD5TOOL"], ["CVAR", "CVAR"], ["GAMEHACK", "GAMEHACK"], ["DUPGUID", "DUPGUID"],
        ["DUPNAME", "DUPNAME"], ["BADNAME", "BADNAME"], ["COMFAIL", "COMFAIL"]
      ]
    
  end
end
