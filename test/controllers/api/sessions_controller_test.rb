require 'test_helper'

class Api::SessionsControllerTest < ActionController::TestCase
  test "show while signed in" do
    sign_in_as users(:notch)
    get :show, format: :json
    assert_response 200
    json = parse response
    refute_nil json['current_user']
    refute_nil json['current_character']
  end

  test "show while not signed in" do
    get :show, format: :json
    assert_response 200
    json = parse response
    assert json.empty?
  end
end
