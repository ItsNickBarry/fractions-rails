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
  # TODO dependent destroy
  validates :fraction, :name, presence: true
  # TODO does order of scope have to match migration?
  # TODO can scope be :fraction instead of :fraction_id?
  validates :name, uniqueness: { scope: :fraction,
    message: ""}

  belongs_to :fraction

  has_many :position_memberships
  has_many :characters, through: :position_memberships

  has_many :land_authorizations, as: :authorizee

  has_many :government_authorizations, as: :authorizer
  has_many :government_authorizations, as: :authorizee

end
