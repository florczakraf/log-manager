class Violation < ActiveRecord::Base
  validates :date, :type_name, :details, :ip, :server_id, :name, presence: true
  belongs_to :player
  
  def self.types
    ["MD5TOOL", "CVAR", "GAMEHACK", "DUPGUID", "DUPNAME", "BADNAME", "COMFAIL", "GAME INTEGRITY", "AUTO-UPDATE FAILURE", "NAME SPAM"]
  end
end
