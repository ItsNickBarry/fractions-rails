# == Schema Information
#
# Table name: government_authorizations
#
#  id                 :integer          not null, primary key
#  authorizer_id      :integer
#  authorizer_type    :string
#  authorizee_id      :integer
#  authorizee_type    :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  authorization_type :string           not null
#

class GovernmentAuthorization < ActiveRecord::Base
  # TODO reference authorization type/name
  # TODO validate uniqueness in scope of authorizer/authorizee/authorization_type
  validates :authorizer, :authorizee, :authorization_type, presence: true

  validate :authorizer_has_authorization_type

  belongs_to :authorizer, polymorphic: true
  belongs_to :authorizee, polymorphic: true

  private

    def authorizer_has_authorization_type
      return if authorization_type.nil?
      unless authorizer.class.authorization_types.include? self.authorization_type.to_sym
        errors.add(:authorization_type, "is not valid for authorizer")
      end
    end
end
