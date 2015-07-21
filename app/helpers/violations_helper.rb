module ViolationsHelper
  def ggc_link guid
    link_to image_tag("ggc.jpg"), "http://www.ggc-stream.net/search/server/guid/gid/#{guid}", :target => "_blank"
  end
  
  def set_filters 
    @violation_filter = session[:violation_filter]
    if @violation_filter.nil? || @violation_filter.empty?
      session[:violation_filter] = @viol_types
      @violation_filter = @viol_types
    end

    @server_filter = session[:server_filter]
    if @server_filter.nil? || @server_filter.empty?
      @server_filter = []
      @servers.each { |srv| @server_filter.push(srv.id) }
      session[:server_filter] = @server_filter
    end
  end
end
