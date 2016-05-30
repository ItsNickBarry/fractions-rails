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
  include Investable
  validates :fraction, :name, presence: true
  validates :name, uniqueness: { scope: :fraction, case_sensitive: false,
    message: ""}

  belongs_to :fraction

  has_many :government_authorizations_received, as: :authorizee, class_name: 'GovernmentAuthorization', dependent: :destroy

  has_many :land_authorizations_received, as: :authorizee, class_name: 'LandAuthorization', dependent: :destroy
end
