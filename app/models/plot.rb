class Plot < ActiveRecord::Base
  validates :x, :z, presence: true
  validates :world, uniqueness: { scope: [:x, :z],
    message: "That plot already exists"}
  validates :world, presence: true

  belongs_to :region
  belongs_to :world
  has_one :fraction, through: :region
end
