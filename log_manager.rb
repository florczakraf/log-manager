require 'date'
require 'io/console'
require_relative 'ftp_downloader'

class LogManager
  attr_reader :servers, :log
  
  def initialize(cfg)
    @config = []
    @servers = {}
    @log_name = "master.log"
    @master_log = File.open(@log_name)
    @log = {}
    
    File.open(cfg).each do |line|
      @config.push(line.strip)
    end
    
    load_master_log
    4.step(@config.size-1, 2) { |i| @servers[@config[i]] = @config[i+1] }
    
    #@downloader = FTPDownloader.new(ip, port, user, pass)
  end
  
  def load_master_log
    @master_log.each { |line| @log[line[0..-5]] = line[-3] }
  end
  
  def save_master_log
    @master_log.close
    open(@log_name, 'w') do |f|
      @log.each { |key, val| f << key << "[" << val << "]\n" }
    end
  end

  def parse_into_log(file)
    File.open(file).each { |line| @log[line.chomp] = ' ' unless @log.has_key?(line.chomp) || 
                                                               (line.include?'(COMFAIL)') || 
                                                               (line.include?'(DUPGUID)') || 
                                                               (line.include?'(DUPNAME)') || 
                                                               (line.include?'(AUTO-UPDATE FAILURE)') ||
                                                               (line.include?'(BADNAME)') ||
                                                               (line.include?'r_aasamples = ') ||
                                                               (line.include?'(NAME SPAM)')
    }
  end
  
  def update_all
    ip = @config[0]
    port = @config[1]
    user = @config[2]
    pass = @config[3]
  
    downloader = FTPDownloader.new(ip, port, user, pass)
  
    @servers.each do |name, srv|
      puts "attempting to download #{name} sv_viol.log"
      downloader.download("/109.169.20.171_#{srv}/pb/sv_viol.log", "to_parse/#{srv}sv_viol.log")
      puts "attempting to download #{name} sv_cheat.log"
      downloader.download("/109.169.20.171_#{srv}/pb/sv_cheat.log", "to_parse/#{srv}sv_cheat.log")
    end
    
    @servers.values.each do |srv|
      parse_into_log("to_parse/#{srv}sv_viol.log")
      parse_into_log("to_parse/#{srv}sv_cheat.log")
    end
    
    puts "Master log has been updated!"
    downloader.close
  end
  
  def get_unchecked
    to_check = ''
  
    @log.each do |key, val|
      if (val == ' ')
        to_check = key
        puts "#{key}[ ]"
        break
      end
    end
    
    c = ''
    
    while (c != "q")
      c = read_char
      case c
      when " "
        toggle_key(to_check)
      when "h"
        puts "Help:", "space - toggle checked", "h - help", "n - next case", "q - return to main menu"
      when "n"
        get_unchecked
      when "q"
      
      else
        puts "SOMETHING ELSE: #{c.inspect}"
      end
    end
    
    
    
  end
  
  def run
    sort_log
    c = ''
    
    while (c != "q")
      c = read_char
      case c
      when "u"
        update_all
      when "n"
        get_unchecked
      when "h"
        puts "Help:", "u - update", "n - unchecked cases", "h - help", "q - quit"
      when "q"
      
      else
        puts "unknown command: #{c.inspect}"
      end
    end
    save_master_log
  end
  
  def sort_log
    @log = (@log.sort_by { |key, _| DateTime.strptime(key[1...20], '%m.%d.%Y %H:%M:%S') }).to_h
  end
  
  def toggle_key(key)
    if @log[key] == ' '
      @log[key] = 'x'
      puts "#{key}[x]"
    else
      @log[key] = ' '
      puts "#{key}[ ]"
    end
  end
  
  def read_char
    begin
      # save previous state of stty
      #old_state = `stty -g`
      # disable echoing and enable raw (not having to press enter)
      STDIN.raw!
      c = STDIN.getc.chr
      # gather next two characters of special keys
      if(c=="\e")
        extra_thread = Thread.new{
          c = c + STDIN.getc.chr
          c = c + STDIN.getc.chr
        }
        # wait just long enough for special keys to get swallowed
        extra_thread.join(0.00001)
        # kill thread so not-so-long special keys don't wait on getc
        extra_thread.kill
      end
    rescue => ex
      puts "#{ex.class}: #{ex.message}"
      puts ex.backtrace
    ensure
      # restore previous state of stty
      #system "stty #{old_state}"
    end
    c
  end
end

lm = LogManager.new("config.cfg")
lm.run

#puts lm.servers
#puts lm.config