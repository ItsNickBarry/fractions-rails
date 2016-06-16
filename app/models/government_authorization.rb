# == Schema Information
#
# Table name: government_authorizations
#
#  id                 :integer          not null, primary key
#  authorizer_id      :integer          not null
#  authorizer_type    :string           not null
#  authorizee_id      :integer          not null
#  authorizee_type    :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  authorization_type :string           not null
#

class GovernmentAuthorization < ActiveRecord::Base
  validates :authorization_type, uniqueness: {
    scope: [:authorizer_id, :authorizer_type, :authorizee_id, :authorizee_type],
    message: ""}
  validates :authorizer, :authorizee, :authorization_type, presence: true
  validate :authorization_type_exists, if: [:authorization_type, :authorizer]

  belongs_to :authorizer, polymorphic: true
  belongs_to :authorizee, polymorphic: true

  # ####
  # TODO delegatable authorizations
  # has_many :delegated_government_authorizations
  # has_many :delegated_authorizees, through: :delegated_government_authorizations
  # ####

  private

    def authorization_type_exists
      unless authorizer.class.government_authorization_types.include? self.authorization_type.to_sym
        errors.add(:authorization_type, "is not valid for authorizer")
      end
    end
end
