# == Schema Information
#
# Table name: position_memberships
#
#  id           :integer          not null, primary key
#  character_id :integer          not null
#  position_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PositionMembership < ActiveRecord::Base
  # TODO dependent destroy
  validates :character, :position, presence: true
  # TODO add message
  validates :character, uniqueness: { scope: :position,
    message: ""}

  belongs_to :character
  belongs_to :position

  has_one :fraction, through: :position
end
