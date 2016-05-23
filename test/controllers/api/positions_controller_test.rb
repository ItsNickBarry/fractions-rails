require 'test_helper'

class Api::PositionsControllerTest < ActionController::TestCase
  test "show" do
    position = positions(:united_kingdom_monarch)
    get :show, id: position.id, format: :json
    assert_response 200

    parse response

    assert_equal position.id,             @json['id']
    assert_equal position.name,           @json['name']
    assert_equal position.created_at,     @json['created_at']

    assert_equal position.fraction.id,    @json['fraction']['id']
    assert_equal position.fraction.name,  @json['fraction']['name']

    assert_equal position.members.length, @json['members'].length

    authorizations = @json['current_character_government_authorizations']

    assert authorizations['executable'].empty?
    assert authorizations['callable'].empty?
    assert authorizations['votable'].empty?
  end

  test "show while signed in" do
    skip 'assert position government authorizations'
  end

  test "create" do
    fraction = fractions(:norge)
    sign_in_as users(:notch)
    act_as characters(:haakon_vii)
    assert_difference 'fraction.positions.count', 1 do
      assert_difference 'Position.count', 1 do
        post :create, fraction_id: fraction.id, position: { name: 'New Position' }, format: :json
        assert_response 200
        assert_template :show
      end
    end
  end

  test "create duplicate" do
    fraction = fractions(:norge)
    sign_in_as users(:notch)
    act_as characters(:haakon_vii)
    assert_no_difference 'fraction.positions.count' do
      assert_no_difference 'Position.count' do
        post :create, fraction_id: fraction.id, position: { name: 'People of Norge' }, format: :json
        assert_response 422
      end
    end
  end

  test "create without authorization" do
    fraction = fractions(:norge)
    sign_in_as users(:notch)
    act_as characters(:elizabeth_ii)
    assert_no_difference 'fraction.positions.count' do
      assert_no_difference 'Position.count' do
        post :create, fraction_id: fraction.id, position: { name: 'New Position' }, format: :json
        assert_response 403
      end
    end
  end
end
