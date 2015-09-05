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
  # TODO dependent destroy
  validates :character, :fraction, presence: true
  # TODO add message
  validates :character, uniqueness: { scope: :fraction,
    message: ""}

  belongs_to :character
  belongs_to :fraction
end
