class Fraction < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_ancestry
end
