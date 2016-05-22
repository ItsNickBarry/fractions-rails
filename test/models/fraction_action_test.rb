require 'test_helper'

class FractionActionTest < ActiveSupport::TestCase
  test "should connect child to parent by mutual agreement" do
    # https://en.wikipedia.org/wiki/Saatse_Boot
    old_parent = fractions(:росси́я)
    new_parent = fractions(:eesti)
    child = fractions(:saatse_saabas)

    assert_difference 'old_parent.children.count', -1 do
      old_parent.child_disconnect! child
      assert_nil child.parent
    end

    assert_no_difference 'new_parent.children.count' do
      assert_difference 'FractionConnectionRequest.count', 1 do
        new_parent.child_connect! child
        assert_nil child.parent
      end
    end

    assert_difference 'new_parent.children.count', 1 do
      assert_difference 'FractionConnectionRequest.count', -1 do
        child.parent_connect! new_parent
        assert_equal new_parent, child.parent
      end
    end
  end

  test "should connect parent to child by mutual agreement" do
    # https://en.wikipedia.org/wiki/Saatse_Boot
    old_parent = fractions(:росси́я)
    new_parent = fractions(:eesti)
    child = fractions(:saatse_saabas)

    assert_difference 'old_parent.children.count', -1 do
      old_parent.child_disconnect! child
      assert_nil child.parent
    end

    assert_no_difference 'new_parent.children.count' do
      assert_difference 'FractionConnectionRequest.count', 1 do
        child.parent_connect! new_parent
        assert_nil child.parent
      end
    end

    assert_difference 'new_parent.children.count', 1 do
      assert_difference 'FractionConnectionRequest.count', -1 do
        new_parent.child_connect! child
        assert_equal new_parent, child.parent
      end
    end
  end

  test "should disconnect child without consent" do
    parent = fractions(:united_states)
    child = fractions(:florida)
    # bye
    assert_difference 'parent.children.count', -1 do
      assert_equal parent, child.parent
      parent.child_disconnect! child
      assert_nil child.parent
    end
  end

  test "should disconnect parent without consent" do
    # https://en.wikipedia.org/wiki/Donetsk#Events_in_2014
    child = fractions(:донецьк)
    parent = fractions(:кри́мський_піво́стрів)
    # 2014
    assert_difference 'parent.children.count', -1 do
      assert_equal parent, child.parent
      child.parent_disconnect!
      assert_nil child.parent
    end
  end

  test "should not replace connected parent" do
    # TODO should child with parent be allowed to request parent at all?
    # https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation
    old_parent = fractions(:україна)
    new_parent = fractions(:росси́я)
    child = fractions(:кри́мський_піво́стрів)
    # 2014
    assert_equal old_parent, child.parent

    assert_difference 'FractionConnectionRequest.count', 1 do
      new_parent.child_connect! child
    end

    assert_no_difference 'FractionConnectionRequest.count' do
      child.parent_connect! new_parent
    end

    assert_equal old_parent, child.parent
  end

  test "should create fraction" do
    # https://en.wikipedia.org/wiki/Liberia#Early_settlement
    fraction = fractions(:united_states)
    # 1822
    assert_difference 'fraction.founded_fractions.count', 1 do
      child = fraction.fraction_create! name: 'Liberia'
      refute_nil fraction.founded_fractions.find_by name: 'Liberia'
      assert child.persisted?
      assert_equal fraction, child.founder
      refute_equal fraction, child.parent
    end
  end

  test "should create and destroy electorate" do
    # https://en.wikipedia.org/wiki/Rigsdagen
    fraction = fractions(:danmark)
    # 1849
    electorate = nil
    assert_difference 'fraction.electorates.count', 1 do
      electorate = fraction.electorate_create! name: 'Rigsdagen'
      refute_nil fraction.electorates.find_by name: 'Rigsdagen'
      assert electorate.persisted?
    end
    # 1953
    assert_difference 'fraction.electorates.count', -1 do
      fraction.electorate_destroy! electorate
      assert_nil fraction.electorates.find_by name: 'Rigsdagen'
      refute electorate.persisted?
    end
  end

  test "should create and destroy position" do
    # https://en.wikipedia.org/wiki/Estonia_in_World_War_II#German_occupation
    fraction = fractions(:eesti)
    # 1936
    position = nil
    assert_difference 'fraction.positions.count', 1 do
      position = fraction.position_create! name: 'Sicherheitspolizei'
      refute_nil fraction.positions.find_by name: 'Sicherheitspolizei'
      assert position.persisted?
    end
    # 1939
    assert_difference 'fraction.positions.count', -1 do
      fraction.position_destroy! position
      assert_nil fraction.positions.find_by name: 'Sicherheitspolizei'
      refute position.persisted?
    end
  end

  test "should create and destroy region" do
    # https://en.wikipedia.org/wiki/Swedish_Gold_Coast
    fraction = fractions(:sverige)
    # 1650
    region = nil
    assert_difference 'fraction.regions.count', 1 do
      region = fraction.region_create! name: 'Svenska Guldkusten'
      refute_nil fraction.regions.find_by name: 'Svenska Guldkusten'
      assert region.persisted?
    end
    # 1663
    assert_difference 'fraction.regions.count', -1 do
      fraction.region_destroy! region
      assert_nil fraction.regions.find_by name: 'Svenska Guldkusten'
      refute region.persisted?
    end
  end

  test "should banish and unbanish character" do
    # https://en.wikipedia.org/wiki/Haakon_VII_of_Norway#Government_in_exile
    fraction = fractions(:norge)
    character = characters(:haakon_vii)
    # 1940
    assert_difference 'fraction.banished_characters.count', 1 do
      refute_nil fraction.characters.find_by name: character.name
      fraction.character_banish! character
      assert_nil fraction.characters.find_by name: character.name
      refute_nil fraction.banished_characters.find_by name: character.name
    end
    # 1945
    assert_difference 'fraction.banished_characters.count', -1 do
      fraction.character_unbanish! character
      assert_nil fraction.banished_characters.find_by name: character.name
    end
  end

  test "should invite and uninvite character" do
    # TODO uninvite
    # https://en.wikipedia.org/wiki/Haakon_VII_of_Norway#Government_in_exile
    fraction = fractions(:united_kingdom)
    character = characters(:haakon_vii)
    # 1940
    assert_difference 'fraction.fraction_invitations.count', 1 do
      fraction.character_invite! character
      refute_nil fraction.fraction_invitations.find_by character: character
    end
    # ????
    assert_difference 'fraction.fraction_invitations.count', -1 do
      fraction.character_uninvite! character
      assert_nil fraction.fraction_invitations.find_by character: character
    end
  end
end
