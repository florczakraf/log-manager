module ServersHelper
  def screenshot_viewer_link ip, port
    link_to '[LINK]', "ftp://109.169.20.171:8821/#{ip}_#{port}/pb/svss/msgpbssv.html"
  end
end
