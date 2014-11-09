class Player < ActiveRecord::Base

  validates :guid, presence: true, uniqueness: true
  
  has_many :violations

end
