require 'test_helper'

class Api::SessionsControllerTest < ActionController::TestCase
  test "show while signed in" do
    sign_in_as users(:notch)
    get :show, format: :json
    assert_response 200
    parse response
    refute_nil @json['current_user']
    refute_nil @json['current_character']

    assert_equal @current_user.id,        @json['current_user']['id']
    assert_equal @current_user.username,  @json['current_user']['username']
    assert_equal @current_character.id,   @json['current_character']['id']
    assert_equal @current_character.name, @json['current_character']['name']
  end

  test "show while not signed in" do
    get :show, format: :json
    assert_response 200
    parse response
    assert @json.empty?
  end
end
