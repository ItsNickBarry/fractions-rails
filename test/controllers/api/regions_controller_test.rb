require 'test_helper'

class Api::RegionsControllerTest < ActionController::TestCase
  test "show" do
    region = regions(:visby_lands_of_visby)
    get :show, id: region.id, format: :json
    assert_response 200

    parse response

    assert_equal region.id,             @json['id']
    assert_equal region.name,           @json['name']
    assert_equal region.created_at,     @json['created_at']

    assert_equal region.fraction.id,    @json['fraction']['id']
    assert_equal region.fraction.name,  @json['fraction']['name']

    authorizations = @json['current_character_government_authorizations']

    assert authorizations['executable'].empty?
    assert authorizations['callable'].empty?
    assert authorizations['votable'].empty?
  end

  test "show while signed in" do
    skip 'assert region government authorizations'
  end

  test "create" do
    fraction = fractions(:norge)
    sign_in_as users(:notch)
    act_as characters(:haakon_vii)
    assert_difference 'fraction.regions.count', 1 do
      assert_difference 'Region.count', 1 do
        post :create, fraction_id: fraction.id, region: { name: 'New Region' }, format: :json
        assert_response 200
        assert_template :show
      end
    end
  end

  test "create duplicate" do
    fraction = fractions(:norge)
    sign_in_as users(:notch)
    act_as characters(:haakon_vii)
    assert_no_difference 'fraction.regions.count' do
      assert_no_difference 'Region.count' do
        post :create, fraction_id: fraction.id, region: { name: 'Lands of Norge' }, format: :json
        assert_response 422
      end
    end
  end

  test "create without authorization" do
    fraction = fractions(:norge)
    sign_in_as users(:notch)
    act_as characters(:elizabeth_ii)
    assert_no_difference 'fraction.regions.count' do
      assert_no_difference 'Region.count' do
        post :create, fraction_id: fraction.id, region: { name: 'New Region' }, format: :json
        assert_response 403
      end
    end
  end
end
