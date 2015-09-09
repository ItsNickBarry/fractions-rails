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
  # TODO npc soldiers will attack banished characters on sight, npc laborers will run away
  # toggle "hostile"/"peaceful" banishment with attribute?
  # TODO realm-wide banishments?  option related to fraction centralization?
  # TODO on create, kick character from fraction's positions
  # TODO dependent destroy
  validates :character, :fraction, presence: true
  # TODO add message
  validates :character, uniqueness: { scope: :fraction,
    message: ""}

  belongs_to :character
  belongs_to :fraction
end
