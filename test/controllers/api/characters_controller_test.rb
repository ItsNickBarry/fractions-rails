require 'test_helper'

class Api::CharactersControllerTest < ActionController::TestCase
  def setup
    @user = users(:carlmanneh)
  end

  test "show" do
    character = characters(:amir_moulavi)
    get :show, id: character.id, format: :json
    assert_response 200

    parse response

    assert_equal character.id,                       @json['id']
    assert_equal character.name,                     @json['name']
    assert_equal character.gender,                   @json['gender']

    assert_equal character.user.id,                  @json['user']['id']
    assert_equal character.user.username,            @json['user']['username']

    assert_equal character.fractions.length,         @json['fractions'].length
    assert_equal character.founded_fractions.length, @json['founded_fractions'].length
  end

  test "create" do
    sign_in_as @user
    assert_difference 'Character.count', 1 do
      post :create, character: { name: 'Carl Manneh', gender: 'M' }, format: :json
      assert_response 200
    end
  end

  test "create multiple" do
    sign_in_as @user
    assert_difference 'Character.count', 1 do
      post :create, character: { name: 'Carl Manneh', gender: 'M' }, format: :json
      assert_response 200
    end

    skip 'should limit number of creatable characters'

    assert_no_difference 'Character.count' do
      post :create, character: { name: 'Karl Manneh', gender: 'M' }, format: :json
      assert_response 422
    end
  end

  test "create while not signed-in" do
    assert_no_difference 'Character.count' do
      post :create, character: { name: 'Carl Manneh', gender: 'M' }, format: :json
      assert_response 401
    end
  end

  test "create with duplicate name" do
    sign_in_as @user
    assert_no_difference 'Character.count' do
      post :create, character: { name: characters(:haakon_vii).name, gender: 'M' }, format: :json
      assert_response 422
    end
  end

  test "create with case-insensitive duplicate name" do
    sign_in_as @user
    assert_no_difference 'Character.count' do
      post :create, character: { name: characters(:haakon_vii).name.swapcase, gender: 'M' }, format: :json
      assert_response 422
    end
  end
end
