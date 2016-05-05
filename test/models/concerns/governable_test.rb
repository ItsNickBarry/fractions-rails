require 'test_helper'

class GovernableTest < ActiveSupport::TestCase

  test "should grant authorization to electorate or position" do
    # https://en.wikipedia.org/wiki/Referendums_in_Sweden
    governable = fractions(:sverige)
    authorizee = electorates(:sverige_electors_of_sverige)
    # 1994
    assert_difference 'governable.government_authorized_electorates.count', 1 do
      governable.authorize! authorizee, :parent_connect
      refute_nil governable.government_authorized_electorates.find_by name: authorizee.name
    end
  end

  test "should authorize character through electorate" do
    governable = fractions(:danmark)
    character = characters(:ida_auken)
    # 2011 - 2015
    assert governable.authorizes? character, :vote, :region_create
    # TODO governable.government_votable_characters
    # refute_nil governable.government_votable_characters.find_by name: character.name
    refute governable.authorizes? character, :execute, :region_create
    assert_nil governable.government_executable_characters.find_by name: character.name
  end

  test "should authorize character through position" do
    # https://en.wikipedia.org/wiki/State_of_emergency#United_Kingdom
    governable = fractions(:united_kingdom)
    character = characters(:elizabeth_ii)

    assert governable.authorizes? character, :execute, :authorize
    refute_nil governable.government_executable_characters.find_by name: character.name
  end

  test "should find authorizations for character" do
    governable = fractions(:danmark)
    character = characters(:hans_andersen)

    government_authorizations = governable.authorizations_for character, :vote
    government_authorizations.each do |authorization|
      assert governable.authorizes? character, :vote, authorization.authorization_type
    end
  end
end
