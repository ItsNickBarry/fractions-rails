require 'test_helper'

class PositionMembershipTest < ActiveSupport::TestCase
  def setup
    # https://en.wikipedia.org/wiki/Villy_S%C3%B8vndal
    @position = positions(:danmark_folketing)
    @position_membership = PositionMembership.new(
      position: @position,
      member: characters(:villy_søvndal)
    )
  end

  test "should be valid" do
    assert @position_membership.valid?
  end

  test "should have position" do
    @position_membership.position = nil
    refute @position_membership.valid?
  end

  test "should have member" do
    @position_membership.member = nil
    refute @position_membership.valid?
  end

  test "member should be unique in scope of position" do
    @position_membership.member = @position.members.first
    refute @position_membership.valid?
  end

  test "should have attributes" do
    skip 'assert attributes'
  end
end
