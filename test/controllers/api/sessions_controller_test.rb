require 'test_helper'

class Api::SessionsControllerTest < ActionController::TestCase
  test "show while signed in" do
    sign_in_as users(:notch)
    get :show, format: :json
    assert_response 200
    parse response
    refute_nil @json['currentUser']
    refute_nil @json['currentCharacter']

    assert_equal @current_user.id,        @json['currentUser']['id']
    assert_equal @current_user.username,  @json['currentUser']['username']
    assert_equal @current_character.id,   @json['currentCharacter']['id']
    assert_equal @current_character.name, @json['currentCharacter']['name']
  end

  test "show while not signed in" do
    get :show, format: :json
    assert_response 200
    parse response
    assert @json.empty?
  end
end
