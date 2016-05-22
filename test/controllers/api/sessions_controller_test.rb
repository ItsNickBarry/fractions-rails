require 'test_helper'

class Api::SessionsControllerTest < ActionController::TestCase
  test "show while signed in" do
    sign_in_as users(:notch)
    get :show, format: :json
    assert_response 200
    response_body = JSON.parse(response.body)
    refute_nil response_body['current_user']
    refute_nil response_body['current_character']
  end

  test "show while not signed in" do
    get :show, format: :json
    assert_response 200
    response_body = JSON.parse(response.body)
    assert response_body.empty?
  end
end
