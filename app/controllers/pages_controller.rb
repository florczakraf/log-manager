require 'net/ftp'

class PagesController < ApplicationController
  
  before_filter :authenticate_user, :only => [:update, :servers]
  before_filter :save_login_state, :only => [ :welcome]

  def welcome
  end
  
  def servers
    @servers = Server.all
  end
  
  def update
    updater
  end
  
  
  def updater
    config = Setting.first
    ip = config.ip
    port = config.port
    user = config.user
    pass = config.pass
    
    connection = Net::FTP.new
    connection.connect(ip, port)
    connection.passive = true
    connection.login(user, pass)
    
    servers = Server.all
    
    servers.each do |srv|
      begin
      connection.gettextfile("/109.169.20.171_#{srv.port}/pb/sv_viol.log", "tmp/#{srv.port}sv_viol.log")
      
      connection.gettextfile("/109.169.20.171_#{srv.port}/pb/sv_cheat.log", "tmp/#{srv.port}sv_cheat.log")
      rescue
      
      end
    end
    
    servers.each do |srv|
      parse_into_db("tmp/#{srv.port}sv_viol.log", srv.id)
      parse_into_db("tmp/#{srv.port}sv_cheat.log", srv.id)
    end
    connection.close
  end

  def parse_into_db(file, srv)
    
    pattern = %r{\[(\d\d.\d\d.\d\d\d\d) (\d\d:\d\d:\d\d)\] VIOLATION \(([A-Z\d]+)\) #(\d+): (.+) \(slot \#\d+\) (.+) \[([a-f\d]+)\(.+\) ([\d\.]+)}
    File.open(file).each  do |line|
      if line =~ pattern
        date = $1
        time = $2
        type = $3
        type_id = $4
        name = $5
        details = $6
        guid = $7
        ip = $8
        
        datetime = date + ' ' + time
        
        player = Player.find_by_guid(guid)
        if (player.nil?)
          player = Player.create(:guid => guid, :banned => false)
        end
        
        begin
          viol = Violation.create(:date => datetime, :type_name => type, :player_id => player.id, :details => details, :ip => ip, :server_id => srv, :name => name)
        rescue
        
        end
      end
    end
  end
end
