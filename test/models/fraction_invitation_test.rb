require 'test_helper'

class FractionInvitationTest < ActiveSupport::TestCase

  def setup
    # https://en.wikipedia.org/wiki/Wernher_von_Braun#American_career
    # 1945
    @fraction_invitation = FractionInvitation.new(
      fraction: fractions(:united_states),
      character: characters(:wernher_von_braun)
    )
  end

  test "should be valid" do
    assert @fraction_invitation.valid?
  end

  test "should have fraction" do
    @fraction_invitation.fraction = nil
    refute @fraction_invitation.valid?
  end

  test "should have character" do
    @fraction_invitation.character = nil
    refute @fraction_invitation.valid?
  end

  test "character should be unique in scope of fraction" do
    @fraction_invitation.save!
    duplicate_fraction_invitation = FractionInvitation.new(
      fraction: @fraction_invitation.fraction,
      character: @fraction_invitation.character
    )
    refute duplicate_fraction_invitation.valid?
  end

  test "invitation of current member should not be valid" do
    @fraction_invitation.character = characters(:barack_obama)
    refute @fraction_invitation.valid?
  end
end
