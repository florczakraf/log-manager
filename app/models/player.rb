class Player < ActiveRecord::Base
  validates :guid, presence: true, uniqueness: true
  validates :guid, length: { is: 32 }
  has_many :violations
end
