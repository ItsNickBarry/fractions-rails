# == Schema Information
#
# Table name: government_authorizations
#
#  id              :integer          not null, primary key
#  authorizer_id   :integer
#  authorizer_type :string
#  authorizee_id   :integer
#  authorizee_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class GovernmentAuthorization < ActiveRecord::Base
  # TODO reference authorization type/name
  # TODO validate uniqueness in scope of authorizer/authorizee/type
  validates :authorizer, :authorizee, presence: true
  
  belongs_to :authorizer, polymorphic: true
  belongs_to :authorizee, polymorphic: true
end
