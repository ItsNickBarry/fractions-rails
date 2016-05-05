require 'test_helper'

class ElectorateActionTest < ActiveSupport::TestCase
  test "should divest and invest member" do
    # TODO investment parameters
    # https://en.wikipedia.org/wiki/George_de_Hevesy
    old_position = positions(:copenhagen_residents)
    new_position = positions(:stockholm_residents)
    character = characters(:george_de_hevesy)
    # 1943
    assert_difference 'old_position.members.count', -1 do
      refute_nil old_position.members.find_by name: character.name
      old_position.divest! character
      assert_nil old_position.members.find_by name: character.name
    end

    assert_difference 'new_position.members.count', 1 do
      assert_nil new_position.members.find_by name: character.name
      new_position.invest! character
      refute_nil new_position.members.find_by name: character.name
    end
  end
end
