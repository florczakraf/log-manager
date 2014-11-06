require 'net/ftp'

class FTPDownloader
  def initialize(ip, port, user, pass)
    @connection = Net::FTP.new
    @connection.connect(ip, port)
    @connection.passive = true
    @connection.login(user, pass)
  end
  
  def close
    @connection.close
  end
  
  def download(file, save)
    result = nil
    begin
      result = @connection.gettextfile(file, save)
    rescue
      
    end
    !result.nil?
  end
end