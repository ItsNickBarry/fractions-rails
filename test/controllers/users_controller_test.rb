require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
    assert_template 'users/new'
    assert_not_nil assigns(:user)
  end
end
