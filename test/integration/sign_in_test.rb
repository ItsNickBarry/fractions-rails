require 'test_helper'

class SignInTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:notch)
  end

  test "sign in with invalid credentials" do
    sign_in_as(@user, '')
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "sign in with valid credentials and sign out" do
    sign_in_as(@user)
    assert is_signed_in?

    # TODO ensure appropriate navbar links for signed-in user

    delete session_path
    follow_redirect!

    assert_not is_signed_in?

    # TODO ensure appropriate navbar links for signed-out user
  end

  test "sign in with case-insensitive username" do
    sign_in_as(@user.username.downcase)
    # do not display a "name has changed" message
    assert flash.empty?
    assert is_signed_in?
  end

  test "sign in with changed username" do
    actual_username = @user.username
    @user.update_attribute(:username, 'asdf')

    assert_nil User.find_by(username: actual_username)
    sign_in_as(actual_username)

    assert is_signed_in?
    assert_not_nil User.find_by(username: actual_username)
    follow_redirect!
    assert_not flash.empty?
  end
end
