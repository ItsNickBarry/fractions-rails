require 'test_helper'

class InvestableTest < ActiveSupport::TestCase
  def setup
    @position = positions(:danmark_folketing)
    @electorate = electorates(:danmark_folketing)
  end

  test "should have memberships of appropriate class" do
    assert_equal PositionMembership, @position.memberships.klass
    assert_equal ElectorateMembership, @electorate.memberships.klass
  end

  test "should have members of appropriate class" do
    assert_equal Character, @position.members.klass
    assert_equal Position, @electorate.members.klass
  end
end
