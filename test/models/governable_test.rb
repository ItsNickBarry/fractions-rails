require 'test_helper'

class GovernableTest < ActiveSupport::TestCase

  # has_many:
  #   government_authorizations, as: :authorizer
  #   government_authorized_[posiitons, electorates]
  #   government_[executable, callable, votable]_characters

  test "should grant authorization to electorate or position" do
    # https://en.wikipedia.org/wiki/Referendums_in_Sweden
    governable = fractions(:sverige)
    authorizee = electorates(:sverige_electors_of_sverige)
    # 1994
    count = governable.government_authorized_electorates.count
    governable.authorize! authorizee, :parent_connect
    assert_not_nil governable.government_authorized_electorates.find_by name: authorizee.name
    assert_equal count + 1, governable.government_authorized_electorates.count
  end

  test "should authorize character through electorate" do
    governable = fractions(:danmark)
    character = characters(:ida_auken)
    # 2011 - 2015
    assert governable.authorizes? character, :vote, :region_create
    # TODO governable.government_votable_characters
    # assert_not_nil governable.government_votable_characters.find_by name: character.name
    assert_not governable.authorizes? character, :execute, :region_create
    assert_nil governable.government_executable_characters.find_by name: character.name
  end

  test "should authorize character through position" do
    # https://en.wikipedia.org/wiki/State_of_emergency#United_Kingdom
    governable = fractions(:united_kingdom)
    character = characters(:elizabeth_ii)

    assert governable.authorizes? character, :execute, :authorize
    assert_not_nil governable.government_executable_characters.find_by name: character.name
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
