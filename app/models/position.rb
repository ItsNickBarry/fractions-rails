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
  # TODO dependent destroy
  validates :fraction, :name, presence: true
  # TODO does order of scope have to match migration?
  validates :name, uniqueness: { scope: :fraction,
    message: ""}

  belongs_to :fraction

  has_many :position_memberships
  has_many :characters, through: :position_memberships

  has_many :land_authorizations, as: :authorizee

  # TODO differentiate between given/received authorizations
  has_many :government_authorizations, as: :authorizer
  has_many :government_authorizations, as: :authorizee

end
