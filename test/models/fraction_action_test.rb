require 'test_helper'

class FractionActionTest < ActiveSupport::TestCase
  test "should connect and disconnect child" do
    # TODO child must also disconnect parent
    # https://en.wikipedia.org/wiki/Saatse_Boot
    росси́я = fractions(:росси́я)
    eesti = fractions(:eesti)
    saatse_saabas = fractions(:saatse_saabas)

    count = росси́я.children.count
    росси́я.child_disconnect! saatse_saabas
    assert_nil saatse_saabas.parent
    assert_equal count - 1, росси́я.children.count

    count = eesti.children.count
    eesti.child_connect! saatse_saabas
    assert_equal eesti, saatse_saabas.parent
    assert_equal count + 1, eesti.children.count
  end

  test "should create fraction" do
    united_states = fractions(:united_states)

    count = united_states.founded_fractions.count
    liberia = united_states.fraction_create! name: 'Liberia'
    assert_not_nil united_states.founded_fractions.find_by name: 'Liberia'
    assert liberia.persisted?
    assert_equal count + 1, united_states.founded_fractions.count
  end

  test "should create and destroy electorate" do
    # https://en.wikipedia.org/wiki/Folketing
    # https://en.wikipedia.org/wiki/Landsting_%28Denmark%29
    danmark = fractions(:danmark)
    # 1849
    count = danmark.electorates.count
    folketing = danmark.electorate_create! name: 'Folketing'
    landsting = danmark.electorate_create! name: 'Landsting'
    assert_not_nil danmark.electorates.find_by name: 'Folketing'
    assert_not_nil danmark.electorates.find_by name: 'Landsting'
    assert folketing.persisted?
    assert landsting.persisted?
    assert_equal count + 2, danmark.electorates.count
    # 1953
    danmark.electorate_destroy! landsting
    assert_nil danmark.electorates.find_by name: 'Landsting'
    assert_not landsting.persisted?
  end

  test "should create and destroy position" do
    # https://en.wikipedia.org/wiki/Estonia_in_World_War_II#German_occupation
    eesti = fractions(:eesti)
    # 1936
    sicherheitspolizei = eesti.position_create! name: 'Sicherheitspolizei'
    assert_not_nil eesti.positions.find_by name: 'Sicherheitspolizei'
    assert sicherheitspolizei.persisted?
    # 1939
    eesti.position_destroy! sicherheitspolizei
    assert_nil eesti.positions.find_by name: 'Sicherheitspolizei'
    assert_not sicherheitspolizei.persisted?
  end

  test "should create and destroy region" do
    # https://en.wikipedia.org/wiki/Swedish_Gold_Coast
    sverige = fractions(:sverige)
    # 1650
    svenska_guldkusten = sverige.region_create! name: 'Svenska Guldkusten'
    assert_not_nil sverige.regions.find_by name: 'Svenska Guldkusten'
    assert svenska_guldkusten.persisted?
    # 1663
    sverige.region_destroy! svenska_guldkusten
    assert_nil sverige.regions.find_by name: 'Svenska Guldkusten'
    assert_not svenska_guldkusten.persisted?
  end

  test "should banish and unbanish character" do
    # TODO remove banished character from positions and electorates
    # https://en.wikipedia.org/wiki/Haakon_VII_of_Norway#Government_in_exile
    norge = fractions(:norge)
    haakon_vii = characters(:haakon_vii)
    # 1940
    norge.character_banish! haakon_vii
    assert_not_nil norge.banished_characters.find_by name: haakon_vii.name
    # 1945
    norge.character_unbanish! haakon_vii
    assert_nil norge.banished_characters.find_by name: haakon_vii.name
  end

  test "should invite character" do
    # TODO store invitation
    # https://en.wikipedia.org/wiki/Haakon_VII_of_Norway#Government_in_exile
    united_kingdom = fractions(:united_kingdom)
    haakon_vii = characters(:haakon_vii)
    # 1940
    united_kingdom.character_invite! haakon_vii
    skip 'assert invitation exists'
  end
end
