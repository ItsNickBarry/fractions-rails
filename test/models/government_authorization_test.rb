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

require 'test_helper'

class GovernmentAuthorizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
