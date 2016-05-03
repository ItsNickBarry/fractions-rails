require 'test_helper'

class ElectorateActionTest < ActiveSupport::TestCase
  test "should divest and invest position" do
    # https://en.wikipedia.org/wiki/District_of_Columbia_voting_rights#History
    electorate = electorates(:united_states_electoral_college)
    position = positions(:washington_representatives)
    # 1788
    count = electorate.members.count
    electorate.divest! position
    assert_nil electorate.members.find_by name: position.name
    assert_equal count - 1, electorate.members.count
    # 1961
    count = electorate.members.count
    electorate.invest! position
    assert_not_nil electorate.members.find_by name: position.name
    assert_equal count + 1, electorate.members.count
  end
end
