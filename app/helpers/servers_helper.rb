module ServersHelper
  def screenshot_viewer_link ip, port
    link_to '[LINK]', "ftp://#{ENV['BASE_ADDRESS']}:#{ENV['FTP_PORT']}/#{ip}_#{port}/pb/svss/msgpbssv.html", target: "_blank"
  end
end
