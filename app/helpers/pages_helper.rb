require 'net/ftp'

module PagesHelper

  def update_db
    ip = ENV['BASE_ADDRESS']
    port = ENV['FTP_PORT']
    user = ENV['FTP_USER']
    pass = ENV['FTP_PASSWORD']
    
    begin
      connection = Net::FTP.new
      connection.connect(ip, port)
      connection.passive = true
      connection.login(user, pass)
      
      servers = Server.all
      servers.each do |srv|
        begin
          connection.gettextfile("/#{srv.ip}_#{srv.port}/pb/sv_viol.log", "tmp/#{srv.port}sv_viol.log")
          connection.gettextfile("/#{srv.ip}_#{srv.port}/pb/sv_cheat.log", "tmp/#{srv.port}sv_cheat.log")
        rescue
          logger.info "Downloading for: #{srv.ip}:#{srv.port} failed."
        end
      end
      
      servers.each do |srv|
        parse_into_db("tmp/#{srv.port}sv_viol.log", srv.id)
        parse_into_db("tmp/#{srv.port}sv_cheat.log", srv.id)
      end
      connection.close
    rescue
      flash[:notice] = "There was an error during update."
      redirect_to(:root)
    end
  end

  def parse_into_db(file, srv)
    pattern = %r{\[(\d\d.\d\d.\d\d\d\d) (\d\d:\d\d:\d\d)\] VIOLATION \(([A-Z\d\ -]+)\) #(\d+): (.+) \(slot \#\d+\) (.+) \[([a-f\d]+)\(.+\) ([\d\.]+)}
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
        if player.nil?
          player = Player.create(:guid => guid, :banned => false)
        end
        
        begin
          viol = Violation.create(:date => datetime, :type_name => type, :player_id => player.id, :details => details, :ip => ip, :server_id => srv, :name => name)
        rescue
          logger.info "Violation was not added to db."
        end
      end
    end
  end
end
