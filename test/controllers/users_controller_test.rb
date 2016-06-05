require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert_response :success
    assert_template 'users/new'
    refute_nil assigns(:user)
  end

  test "create with invalid credentials" do
    [
      { name: 'a' * 17,       password: 'password' },
      { name: 'itsnickbarry', password: ''         }
    ].each do |user|
      assert_no_difference 'User.count' do
        post :create, user: user
      end
      assert_template 'users/new'
      refute flash.empty?
      refute_nil assigns(:user).name
    end
  end

  test "create with valid, case-insensitive credentials" do
    assert_difference 'User.count' do
      post :create, user: { name: 'itsnickbarry', password: 'password' }
    end
    user = assigns(:user)

    refute is_signed_in?

    skip 'assert not activated'
    skip 'assert activation instructions page'
  end

  test "create while signed-in" do
    sign_in_as users(:notch)
    assert_no_difference 'User.count' do
      post :create, user: { name: 'itsnickbarry', password: 'password' }
    end
    assert_response 422
  end
end
