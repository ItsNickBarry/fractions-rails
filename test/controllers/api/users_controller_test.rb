require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase
  test "show" do
    get :show, id: users(:notch).id, format: :json
    assert_response 200
    response_body = JSON.parse(response.body)
    refute_nil response_body['id']
    refute_nil response_body['uuid']
    refute_nil response_body['username']
    
    refute_nil response_body['characters']
  end
end
