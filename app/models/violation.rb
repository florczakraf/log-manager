class Violation < ActiveRecord::Base
  validates :date, presence: true
  validates :type_name, presence: true
  validates :details, presence: true
  validates :ip, presence: true
  validates :server_id, presence: true
  validates :name, presence: true
  
  belongs_to :player

end
