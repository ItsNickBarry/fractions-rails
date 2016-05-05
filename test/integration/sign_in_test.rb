require 'test_helper'

class SignInTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:notch)
  end

  test "sign in with invalid credentials" do
    sign_in_as(@user, '')
    refute flash.empty?
    get root_path
    assert flash.empty?
  end

  test "sign in with valid credentials and sign out" do
    sign_in_as(@user)
    follow_redirect!
    assert is_signed_in?

    delete session_path
    follow_redirect!
    assert_template 'static_pages/root'
    refute is_signed_in?
  end

  test "sign in with case-insensitive username" do
    sign_in_as(@user.username.downcase)
    # do not display a "name has changed" message
    assert flash.empty?
    assert is_signed_in?
  end

  test "sign in with changed username" do
    actual_username = @user.username
    # save incorrect username to database, to simulate outdated username
    @user.update_attribute(:username, 'asdf')

    assert_nil User.find_by(username: actual_username)
    sign_in_as(actual_username)

    assert is_signed_in?
    refute_nil User.find_by(username: actual_username)
    follow_redirect!
    refute flash.empty?
  end

  test "signed-out user should have 'sign-up' and 'sign-in' links" do
    refute is_signed_in?
    get root_path
    assert_template 'static_pages/root'
    assert_select 'a[href=?]', session_url,     count: 0
    assert_select 'a[href=?]', new_user_url,    count: 1
    assert_select 'a[href=?]', new_session_url, count: 1
  end

  test "signed-in user should have 'sign-out' link" do
    sign_in_as @user
    follow_redirect!
    assert_template 'static_pages/root'
    assert_select 'a[href=?]', session_url,     count: 1
    assert_select 'a[href=?]', new_user_url,    count: 0
    assert_select 'a[href=?]', new_session_url, count: 0
  end
end
