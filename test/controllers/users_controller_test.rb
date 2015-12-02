require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test 'should get user#new' do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test 'should create user' do
    assert_difference('User.count') do
      post :create, user: { username: 'ItsNickBarry', password: 'password' }
    end
  end

  test 'should not create user without matching Minecraft account' do
    assert_no_difference('User.count') do
      post :create, user: { username: 'a' * 17, password: 'password' }
    end
  end
end
