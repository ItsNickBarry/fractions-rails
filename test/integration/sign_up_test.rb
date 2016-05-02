require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test "sign up with invalid credentials" do
    [
      { username: 'a' * 17, password: 'password' },
      { username: 'asdf', password: '' }
    ].each do |user|
      assert_no_difference 'User.count' do
        post users_path, user: user
      end
      assert_template 'users/new'
      assert_not flash.empty?
      assert_not_nil assigns(:user).username
    end

    get root_path
    assert flash.empty?
  end

  test "sign up with valid, case-insensitive credentials" do
    assert_difference 'User.count' do
      post users_path, user: { username: 'itsnickbarry', password: 'password' }
    end
    user = assigns(:user)

    assert_not is_signed_in?

    skip 'assert not activated'
  end
end
