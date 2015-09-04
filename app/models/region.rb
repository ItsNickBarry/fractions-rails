# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  fraction_id :integer          not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Region < ActiveRecord::Base
  include Governable
  # TODO dependent destroy
  validates :fraction, :name, presence: true
  # TODO does order of scope have to match migration?
  validates :name, uniqueness: { scope: :fraction,
    message: ""}

  belongs_to :fraction
  has_many :plots

  has_many :land_authorizations
  has_many :government_authorizations, as: :authorizer

  def self.land_authorization_types
    [
      :build
    ]
  end
end
