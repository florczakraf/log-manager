class Updater
  @queue = :updater
  
  def self.perform
    ip = "109.169.20.171"
    port = "8821"
    user = "b3"
    pass = "7x7X4s7eFMrnmW5J"
    
    connection = Net::FTP.new
    connection.connect(ip, port)
    connection.passive = true
    connection.login(user, pass)
    
    servers = Server.all
    
    servers.each do |srv|
      #puts "attempting to download #{name} sv_viol.log"
      connection.download("/109.169.20.171_#{srv.ip}/pb/sv_viol.log", "tmp/#{srv.ip}sv_viol.log")
      #puts "attempting to download #{name} sv_cheat.log"
      connection.download("/109.169.20.171_#{srv.ip}/pb/sv_cheat.log", "tmp/#{srv.ip}sv_cheat.log")
    end
    
    @servers.values.each do |srv|
      parse_into_db("tmp/#{srv.ip}sv_viol.log", srv.id)
      parse_into_db("tmp/#{srv.ip}sv_cheat.log", srv.id)
    end
    @connection.close
  end

  def self.parse_into_db(file, srv)
    #[11.03.2014 22:43:31] VIOLATION (MD5TOOL) #9002: |OK|P3 (slot #2) MD5Tool Mismatch: iw3mp.exe (len=2048) [1f97d04c79e3cc150232cb8d196843bb(VALID) 164.127.209.253:28960]
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
        
        viol = Violation.create(:date => datetime, :type => type, :player_id => player.id, :details => details, :ip => ip, :server_id => srv)
        
      end
    end
  end
end
