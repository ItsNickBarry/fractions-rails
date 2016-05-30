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
  include Investable
  validates :fraction, :name, presence: true
  validates :name, uniqueness: { scope: :fraction, case_sensitive: false,
    message: ""}

  belongs_to :fraction

  has_many :government_authorizations_received, as: :authorizee, class_name: 'GovernmentAuthorization', dependent: :destroy
end
