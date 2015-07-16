# == Schema Information
#
# Table name: land_authorizations
#
#  id              :integer          not null, primary key
#  region_id       :integer          not null
#  authorizee_id   :integer
#  authorizee_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class LandAuthorization < ActiveRecord::Base
  # TODO reference authorization type/name, for now assume all build permissions
  # TODO validate uniqueness in scope of region/authorizee/type
  validates :region, presence: true
  validates :authorizee, presence: true

  # TODO alias :region as :authorizer
  belongs_to :region

  belongs_to :authorizee, polymorphic: true
end
