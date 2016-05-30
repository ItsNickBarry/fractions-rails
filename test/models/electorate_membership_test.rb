require 'test_helper'

class ElectorateMembershipTest < ActiveSupport::TestCase
  def setup
    @electorate = electorates(:united_states_electoral_college)
    @electorate_membership = ElectorateMembership.new(
      electorate: @electorate,
      member: positions(:florida_representatives)
    )
  end

  test "should be valid" do
    assert @electorate_membership.valid?
  end

  test "should have electorate" do
    @electorate_membership.electorate = nil
    refute @electorate_membership.valid?
  end

  test "should have member" do
    @electorate_membership.member = nil
    refute @electorate_membership.valid?
  end

  test "member should be unique in scope of electorate" do
    @electorate_membership.member = @electorate.members.first
    refute @electorate_membership.valid?
  end

  test "should have attributes" do
    skip 'assert attributes'
  end
end
