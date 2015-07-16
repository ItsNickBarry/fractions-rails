# == Schema Information
#
# Table name: plots
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  world_id   :integer          not null
#  x          :integer          not null
#  z          :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Plot < ActiveRecord::Base
  validates :x, :z, presence: true
  validates :world, uniqueness: { scope: [:x, :z],
    message: "That plot already exists"}
  validates :world, presence: true

  belongs_to :region
  belongs_to :world
  has_one :fraction, through: :region
end
