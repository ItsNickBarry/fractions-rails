require 'test_helper'

class Api::FractionsControllerTest < ActionController::TestCase
  test "index" do
    get :index, format: :json
    assert_response 200
    json = parse response
    refute_nil json['roots']
  end

  test "show" do
    fraction = fractions(:eesti)
    get :show, id: fraction.id, format: :json
    assert_response 200
    json = parse response

    assert_equal fraction.id,                       json['id']
    assert_equal fraction.name,                     json['name']
    assert_equal fraction.founder_type,             json['founder_type']
    assert_equal fraction.created_at,               json['created_at']

    assert_equal fraction.founder.id,               json['founder']['id']
    assert_equal fraction.founder.name,             json['founder']['name']

    assert_equal fraction.founded_fractions.length, json['founded_fractions'].length
    assert_equal fraction.children.length,          json['children'].length
    assert_equal fraction.electorates.length,       json['electorates'].length
    assert_equal fraction.positions.length,         json['positions'].length
    assert_equal fraction.regions.length,           json['regions'].length
  end

  test "show while signed in" do
    skip 'assert current_character_government_authorizations'
  end

  test "create as character" do
    sign_in_as users(:minecraftchick)
    assert_difference 'Fraction.count', 1 do
      post :create, fraction: { name: 'Pristina' }, founder: { id: nil }, format: :json
      assert_response 200
    end
  end

  test "create multiple as character" do
    sign_in_as users(:minecraftchick)
    assert_difference 'Fraction.count', 1 do
      post :create, fraction: { name: 'Pristina' }, founder: { id: nil }, format: :json
      assert_response 200
    end

    assert_no_difference 'Fraction.count', 1 do
      post :create, fraction: { name: 'Pristina Two' }, founder: { id: nil }, format: :json
      assert_response 422
    end

    skip 'assert ability to create multiple under certain conditions'
  end

  test "create as fraction" do
    # https://en.wikipedia.org/wiki/Liberia#Early_settlement
    fraction = fractions(:united_states)
    user = users(:minecraftchick)

    sign_in_as user
    act_as characters(:james_monroe)
    # 1822
    assert_difference 'fraction.founded_fractions.count', 1 do
      assert_difference 'Fraction.count', 1 do
        post :create, fraction: { name: 'Liberia' }, founder: { id: fraction.id }, format: :json
        assert_response 200
      end
    end
  end
end
