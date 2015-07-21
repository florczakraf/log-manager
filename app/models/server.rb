class Server < ActiveRecord::Base
  validates :name, :ip, :port, presence: true
end
