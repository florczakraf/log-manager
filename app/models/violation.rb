class Violation < ActiveRecord::Base
  validates :date, :type_name, :details, :ip, :server_id, :name, presence: true
  belongs_to :player
end
