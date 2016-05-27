require 'test_helper'

class Api::ElectoratesControllerTest < ActionController::TestCase
  test "show" do
    electorate = electorates(:danmark_folketing)
    get :show, id: electorate.id, format: :json
    assert_response 200

    parse response

    assert_equal electorate.id,             @json['id']
    assert_equal electorate.name,           @json['name']
    assert_equal electorate.created_at,     @json['created_at']

    assert_equal electorate.fraction.id,    @json['fraction']['id']
    assert_equal electorate.fraction.name,  @json['fraction']['name']

    assert_equal electorate.members.length, @json['members'].length

    authorizations = @json['current_character_government_authorizations']

    assert authorizations['executable'].empty?
    assert authorizations['callable'].empty?
    assert authorizations['votable'].empty?
  end

  test "show while signed in" do
    skip 'assert electorate government authorizations'
  end

  test "create" do
    fraction = fractions(:norge)
    act_as characters(:haakon_vii)
    assert_difference 'fraction.electorates.count', 1 do
      assert_difference 'Electorate.count', 1 do
        post :create, fraction_id: fraction.id, electorate: { name: 'New Electorate' }, format: :json
        assert_response 200
        assert_template :show
      end
    end
  end

  test "create duplicate" do
    fraction = fractions(:norge)
    act_as characters(:haakon_vii)
    assert_no_difference 'fraction.electorates.count' do
      assert_no_difference 'Electorate.count' do
        post :create, fraction_id: fraction.id, electorate: { name: 'Electors of Norge' }, format: :json
        assert_response 422
      end
    end
  end

  test "create without authorization" do
    fraction = fractions(:norge)
    act_as characters(:elizabeth_ii)
    assert_no_difference 'fraction.electorates.count' do
      assert_no_difference 'Electorate.count' do
        post :create, fraction_id: fraction.id, electorate: { name: 'New Electorate' }, format: :json
        assert_response 403
      end
    end
  end
end
