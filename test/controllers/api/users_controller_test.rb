require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase
  test "show" do
    get :show, id: users(:notch).id, format: :json
    assert_response 200
    parse response
    refute_nil @json['id']
    refute_nil @json['uuid']
    refute_nil @json['username']

    refute_nil @json['characters']
  end
end
