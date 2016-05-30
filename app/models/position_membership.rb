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
  validates :member, :position, presence: true
  # TODO add message
  validates :member, uniqueness: { scope: :position,
    message: ""}

  belongs_to :member, class_name: 'Character', foreign_key: :character_id
  belongs_to :position

  has_one :fraction, through: :position
end
