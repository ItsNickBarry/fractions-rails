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

require 'test_helper'

class LandAuthorizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
