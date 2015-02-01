module PlayersHelper
  def ggc_link guid
    link_to image_tag("ggc.jpg"), "http://www.ggc-stream.net/search/server/guid/gid/#{guid}", :target => "_blank"
  end

  def knife_echelon_link guid
    link_to 'Knife Echelon', "http://echelon.ms-gaming.com/cod4/knife/clients.php?s=#{guid}&t=pbid", :target => "_blank"
  end

  def deathrun_echelon_link guid
    link_to 'Deathrun Echelon', "http://echelon.ms-gaming.com/cod4/deathrun/clients.php?s=#{guid}&t=pbid", :target => "_blank"
  end
end
