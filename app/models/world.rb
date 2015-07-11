class World < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
