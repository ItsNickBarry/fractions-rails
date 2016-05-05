require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
    assert_template 'sessions/new'
    refute_nil assigns(:user)
  end
end
