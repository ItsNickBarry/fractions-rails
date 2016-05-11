# == Schema Information
#
# Table name: positions
#
#  id          :integer          not null, primary key
#  fraction_id :integer          not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Position < ActiveRecord::Base
  include Governable
  validates :fraction, :name, presence: true
  # TODO does order of scope have to match migration?
  validates :name, uniqueness: { scope: :fraction,
    message: ""}

  belongs_to :fraction

  has_many :position_memberships, dependent: :destroy
  has_many :members, through: :position_memberships, source: :character

  has_many :land_authorizations_received, as: :authorizee, class_name: 'LandAuthorization', dependent: :destroy

  # TODO differentiate between given/received authorizations
  # as: :authorizer is in Governable module
  has_many :government_authorizations_received, as: :authorizee, class_name: 'GovernmentAuthorization', dependent: :destroy

  def invest! character
    # TODO parameters: term-length
    PositionMembership.create(position: self, character: character)
  end

  def divest! character
    PositionMembership.find_by(position: self, character: character).try(:destroy)
  end
end
