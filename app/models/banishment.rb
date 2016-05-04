# == Schema Information
#
# Table name: banishments
#
#  id           :integer          not null, primary key
#  character_id :integer          not null
#  fraction_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Banishment < ActiveRecord::Base
  # TODO banishment types:
  #   local vs realm-wide: banish from only one fraction vs all descendants
  #   hostile vs peaceful: NPC characters will attack and run away vs ignore
  # TODO on create, kick character from fraction's positions
  validates :character, :fraction, presence: true
  # TODO add message
  validates :character, uniqueness: { scope: :fraction,
    message: ""}

  belongs_to :character
  belongs_to :fraction

  after_create :remove_from_positions

  private

    def remove_from_positions
      # TODO use SQL to do this more efficiently
      fraction.subtree.each do |fraction|
        fraction.positions.each do |position|
          position.divest! character
        end
      end
    end
end
