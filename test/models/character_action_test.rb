require 'test_helper'

class CharacterActionTest < ActiveSupport::TestCase
  test "should accept fraction invitation" do
    # https://en.wikipedia.org/wiki/Haakon_VII_of_Norway#Government_in_exile
    fraction = fractions(:united_kingdom)
    character = characters(:haakon_vii)
    # 1940
    assert_difference 'fraction.characters.count', 1 do
      assert_difference 'FractionInvitation.count', 1 do
        fraction.character_invite! character
      end
      assert_difference 'FractionInvitation.count', -1 do
        character.fraction_join! fraction
      end
      refute_nil character.fractions.find_by name: fraction.name
    end
  end

  test "should not join fraction without invitation" do
    fraction = fractions(:eesti)
    character = characters(:haakon_vii)

    assert_no_difference 'fraction.characters.count' do
      character.fraction_join! fraction
      assert_nil character.fractions.find_by name: fraction.name
    end
  end
end
