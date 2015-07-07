class PositionMembership < ActiveRecord::Base
  # TODO dependent destroy
  validates :character, :position, presence: true
  # TODO add message
  validates :character_id, uniqueness: { scope: :position_id,
    message: ""}

  belongs_to :character
  belongs_to :position
end
