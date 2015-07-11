# == Schema Information
#
# Table name: position_memberships
#
#  id           :integer          not null, primary key
#  character_id :integer          not null
#  position_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class PositionMembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
