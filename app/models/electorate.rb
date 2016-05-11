# == Schema Information
#
# Table name: electorates
#
#  id          :integer          not null, primary key
#  fraction_id :integer          not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Electorate < ActiveRecord::Base
  include Governable
  validates :fraction, :name, presence: true
  # TODO does order of scope have to match migration?
  validates :name, uniqueness: { scope: :fraction,
    message: ""}

  belongs_to :fraction

  has_many :electorate_memberships, dependent: :destroy
  has_many :members, through: :electorate_memberships, source: :position

  # TODO differentiate between given/received authorizations
  # as: :authorizer is in Governable module
  has_many :government_authorizations_received, as: :authorizee, class_name: 'GovernmentAuthorization', dependent: :destroy

  def invest! position
    # TODO parameters
    ElectorateMembership.create(electorate: self, position: position)
  end

  def divest! position
    ElectorateMembership.find_by(electorate: self, position: position).try(:destroy)
  end
end
