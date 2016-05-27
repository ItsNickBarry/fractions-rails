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
    assert_equal fraction.founder_type,             @json['founder_type']
    assert_equal fraction.created_at,               @json['created_at']

    assert_equal fraction.founder.id,               @json['founder']['id']
    assert_equal fraction.founder.name,             @json['founder']['name']

    assert_equal fraction.founded_fractions.length, @json['founded_fractions'].length
    assert_equal fraction.children.length,          @json['children'].length
    assert_equal fraction.electorates.length,       @json['electorates'].length
    assert_equal fraction.positions.length,         @json['positions'].length
    assert_equal fraction.regions.length,           @json['regions'].length

    authorizations = @json['current_character_government_authorizations']

    assert authorizations['executable'].empty?
    assert authorizations['callable'].empty?
    assert authorizations['votable'].empty?
  end

  test "show while signed in" do
    act_as characters(:ida_auken)
    fraction = fractions(:danmark)
    get :show, id: fraction.id, format: :json
    assert_response 200

    parse response

    authorizations = @json['current_character_government_authorizations']


    assert_equal fraction.authorizations_for(@current_character, :execute).length,
                 authorizations['executable'].length
    assert_equal fraction.authorizations_for(@current_character, :call).length,
                 authorizations['callable'].length
    assert_equal fraction.authorizations_for(@current_character, :vote).length,
                 authorizations['votable'].length

    authorizations['executable'].each do |authorization_type|
      assert fraction.authorizes? @current_character, :execute, authorization_type
    end

    authorizations['callable'].each do |authorization_type|
      assert fraction.authorizes? @current_character, :call, authorization_type
    end

    authorizations['votable'].each do |authorization_type|
      assert fraction.authorizes? @current_character, :vote, authorization_type
    end
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
end
