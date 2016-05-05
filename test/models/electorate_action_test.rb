require 'test_helper'

class ElectorateActionTest < ActiveSupport::TestCase
  test "should divest and invest position" do
    # https://en.wikipedia.org/wiki/District_of_Columbia_voting_rights#History
    electorate = electorates(:united_states_electoral_college)
    position = positions(:washington_representatives)
    # 1788
    assert_difference 'electorate.members.count', -1 do
      electorate.divest! position
      assert_nil electorate.members.find_by name: position.name
    end
    # 1961
    assert_difference 'electorate.members.count', 1 do
      electorate.invest! position
      refute_nil electorate.members.find_by name: position.name
    end
  end
end
