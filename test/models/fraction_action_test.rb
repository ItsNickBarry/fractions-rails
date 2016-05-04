require 'test_helper'

class FractionActionTest < ActiveSupport::TestCase
  test "should connect child and parent by mutual agreement" do
    # TODO ensure correct behavior if the child attempts to connect first
    # https://en.wikipedia.org/wiki/Saatse_Boot
    old_parent = fractions(:росси́я)
    new_parent = fractions(:eesti)
    child = fractions(:saatse_saabas)

    count = old_parent.children.count
    old_parent.child_disconnect! child
    assert_nil child.parent
    assert_equal count - 1, old_parent.children.count

    count = new_parent.children.count
    new_parent.child_connect! child
    assert_nil child.parent
    assert_equal count, new_parent.children.count

    child.parent_connect! new_parent
    assert_equal new_parent, child.parent
    assert_equal count + 1, new_parent.children.count
  end

  test "should disconnect child without consent" do
    parent = fractions(:united_states)
    child = fractions(:florida)
    # bye
    count = parent.children.count
    assert_equal parent, child.parent
    parent.child_disconnect! child
    assert_nil child.parent
    assert_equal count - 1, parent.children.count
  end

  test "should disconnect parent without consent" do
    # https://en.wikipedia.org/wiki/Donetsk#Events_in_2014
    child = fractions(:донецьк)
    parent = fractions(:кри́мський_піво́стрів)
    # 2014
    count = parent.children.count
    assert_equal parent, child.parent
    child.parent_disconnect!
    assert_nil child.parent
    assert_equal count - 1, parent.children.count
  end

  test "should not replace connected parent" do
    # TODO should child with parent be allowed to request parent at all?
    # https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation
    old_parent = fractions(:україна)
    new_parent = fractions(:росси́я)
    child = fractions(:кри́мський_піво́стрів)
    # 2014
    assert_equal old_parent, child.parent
    new_parent.child_connect! child
    child.parent_connect! new_parent
    assert_equal old_parent, child.parent
  end

  test "should create fraction" do
    # https://en.wikipedia.org/wiki/Liberia#Early_settlement
    fraction = fractions(:united_states)
    # 1822
    count = fraction.founded_fractions.count
    child = fraction.fraction_create! name: 'Liberia'
    assert_not_nil fraction.founded_fractions.find_by name: 'Liberia'
    assert child.persisted?
    assert_equal fraction, child.founder
    assert_not_equal fraction, child.parent
    assert_equal count + 1, fraction.founded_fractions.count
  end

  test "should create and destroy electorate" do
    # https://en.wikipedia.org/wiki/Rigsdagen
    fraction = fractions(:danmark)
    # 1849
    count = fraction.electorates.count
    electorate = fraction.electorate_create! name: 'Rigsdagen'
    assert_not_nil fraction.electorates.find_by name: 'Rigsdagen'
    assert electorate.persisted?
    assert_equal count + 1, fraction.electorates.count
    # 1953
    count = fraction.electorates.count
    fraction.electorate_destroy! electorate
    assert_nil fraction.electorates.find_by name: 'Rigsdagen'
    assert_not electorate.persisted?
    assert_equal count - 1, fraction.electorates.count
  end

  test "should create and destroy position" do
    # https://en.wikipedia.org/wiki/Estonia_in_World_War_II#German_occupation
    fraction = fractions(:eesti)
    # 1936
    count = fraction.positions.count
    position = fraction.position_create! name: 'Sicherheitspolizei'
    assert_not_nil fraction.positions.find_by name: 'Sicherheitspolizei'
    assert position.persisted?
    assert_equal count + 1, fraction.positions.count
    # 1939
    count = fraction.positions.count
    fraction.position_destroy! position
    assert_nil fraction.positions.find_by name: 'Sicherheitspolizei'
    assert_not position.persisted?
    assert_equal count - 1, fraction.positions.count
  end

  test "should create and destroy region" do
    # https://en.wikipedia.org/wiki/Swedish_Gold_Coast
    fraction = fractions(:sverige)
    # 1650
    count = fraction.regions.count
    region = fraction.region_create! name: 'Svenska Guldkusten'
    assert_not_nil fraction.regions.find_by name: 'Svenska Guldkusten'
    assert region.persisted?
    assert_equal count + 1, fraction.regions.count
    # 1663
    count = fraction.regions.count
    fraction.region_destroy! region
    assert_nil fraction.regions.find_by name: 'Svenska Guldkusten'
    assert_not region.persisted?
    assert_equal count - 1, fraction.regions.count
  end

  test "should banish and unbanish character" do
    # https://en.wikipedia.org/wiki/Haakon_VII_of_Norway#Government_in_exile
    fraction = fractions(:norge)
    character = characters(:haakon_vii)
    # 1940
    count = fraction.banished_characters.count
    assert_not_nil fraction.characters.find_by name: character.name
    fraction.character_banish! character
    assert_nil fraction.characters.find_by name: character.name
    assert_not_nil fraction.banished_characters.find_by name: character.name
    assert_equal count + 1, fraction.banished_characters.count
    # 1945
    count = fraction.banished_characters.count
    fraction.character_unbanish! character
    assert_nil fraction.banished_characters.find_by name: character.name
    assert_equal count - 1, fraction.banished_characters.count
  end

  test "should invite character" do
    # https://en.wikipedia.org/wiki/Haakon_VII_of_Norway#Government_in_exile
    fraction = fractions(:united_kingdom)
    character = characters(:haakon_vii)
    # 1940
    count = fraction.fraction_invitations.count
    fraction.character_invite! character
    assert_not_nil fraction.fraction_invitations.find_by character: character
    assert_equal count + 1, fraction.fraction_invitations.count
  end
end
