require 'test_helper'

class Api::FractionsControllerTest < ActionController::TestCase
  test "index" do
    get :index, format: :json
    assert_response 200
    parse response
    assert_equal Fraction.roots.count, @json['roots'].length
  end

  test "show" do
    fraction = fractions(:eesti)
    get :show, id: fraction.id, format: :json
    assert_response 200

    parse response

    assert_equal fraction.id,                       @json['id']
    assert_equal fraction.name,                     @json['name']
    assert_equal fraction.description,              @json['description']
    assert_equal fraction.created_at,               @json['createdAt']

    assert_equal fraction.founder.id,               @json['founder']['id']
    assert_equal fraction.founder.name,             @json['founder']['name']
    assert_equal fraction.founder.class.to_s,       @json['founder']['type']

    assert_equal fraction.founded_fractions.count,  @json['foundedFractions'].length
    assert_equal fraction.children.count,           @json['children'].length
    assert_equal fraction.electorates.count,        @json['electorates'].length
    assert_equal fraction.positions.count,          @json['positions'].length
    assert_equal fraction.regions.count,            @json['regions'].length

    assert_equal fraction.government_authorizations_given.count,
                 @json['governmentAuthorizationsGiven'].length
  end

  test "show while signed in" do
    act_as characters(:ida_auken)
    fraction = fractions(:danmark)
    get :show, id: fraction.id, format: :json
    assert_response 200

    parse response

    authorizations = @json['governmentAuthorizationsGiven']

    skip 'assert currentCharacter boolean on authorizations given'
  end

  test "create as character" do
    act_as characters(:ida_auken)
    assert_difference 'Fraction.count', 1 do
      post :create, fraction: { name: 'Pristina' }, founder: { id: nil }, format: :json
      assert_response 200
    end
  end

  test "create multiple as character" do
    act_as characters(:ida_auken)

    assert_no_difference 'Fraction.count' do
      post :create, fraction: { name: fractions(:eesti).name }, founder: { id: nil }, format: :json
      assert_response 422
    end

    assert_difference 'Fraction.count', 1 do
      post :create, fraction: { name: 'Pristina' }, founder: { id: nil }, format: :json
      assert_response 200
    end

    assert_no_difference 'Fraction.count', 1 do
      post :create, fraction: { name: 'Pristina Two' }, founder: { id: nil }, format: :json
      assert_response 403
    end

    skip 'assert ability to create multiple under certain conditions'
  end

  test "create as fraction" do
    # https://en.wikipedia.org/wiki/Liberia#Early_settlement
    fraction = fractions(:united_states)

    act_as characters(:james_monroe)
    # 1822
    assert_difference 'fraction.founded_fractions.count', 1 do
      assert_difference 'Fraction.count', 1 do
        post :create, fraction: { name: 'Liberia' }, founder: { id: fraction.id }, format: :json
        assert_response 200
        assert_template :show
      end
    end
  end

  test "create as fraction without authorization" do
    fraction = fractions(:united_states)

    act_as characters(:haakon_vii)
    assert_no_difference 'fraction.founded_fractions.count' do
      assert_no_difference 'Fraction.count' do
        post :create, fraction: { name: 'Liberia' }, founder: { id: fraction.id }, format: :json
        assert_response 403
      end
    end
  end

  test "update" do
    fraction_id = ActiveRecord::FixtureSet.identify(:united_states)
    description = 'Great again?'

    act_as characters(:barack_obama)

    patch :update, id: fraction_id, fraction: { description: description }, format: :json
    assert_response 200
    assert_template :show
    assert_equal description, Fraction.find(fraction_id).description
  end

  test "update without authorization" do
    fraction_id = ActiveRecord::FixtureSet.identify(:united_states)
    description = 'Great again?'

    act_as characters(:ida_auken)

    patch :update, id: fraction_id, fraction: { description: description }, format: :json
    skip 'assert_response 403'
    skip 'refute_equal description, Fraction.find(fraction_id).description'
  end

  test "update with invalid parameters" do
    fraction_id = ActiveRecord::FixtureSet.identify(:united_states)
    name = fractions(:eesti).name

    act_as characters(:barack_obama)

    patch :update, id: fraction_id, fraction: { name: name }, format: :json
    assert_response 422
    refute_equal name, Fraction.find(fraction_id).name
  end
end
