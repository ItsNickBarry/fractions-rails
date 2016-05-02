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

require 'test_helper'

class GovernmentAuthorizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
