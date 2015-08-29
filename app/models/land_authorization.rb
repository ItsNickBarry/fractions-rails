# == Schema Information
#
# Table name: land_authorizations
#
#  id                 :integer          not null, primary key
#  authorizer_id      :integer          not null
#  authorizee_id      :integer
#  authorizee_type    :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  authorization_type :string           not null
#

class LandAuthorization < ActiveRecord::Base
  # TODO reference authorization type/name, for now assume all build permissions
  # TODO validate uniqueness in scope of region/authorizee/type
  validates :authorizer, :authorizee, :authorization_type, presence: true

  validate :valid_authorization_type

  belongs_to :authorizer, class_name: 'Region'
  def region
    authorizer
  end

  belongs_to :authorizee, polymorphic: true

  private

    def valid_authorization_type
      return if authorization_type.nil?
      unless authorizer.class.land_authorization_types.include? self.authorization_type.to_sym
        errors.add(:authorization_type, "is not valid")
      end
    end
end
