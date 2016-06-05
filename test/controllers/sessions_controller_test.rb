require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:notch)
  end

  test "new" do
    get :new
    assert_response :success
    assert_template 'sessions/new'
    refute_nil assigns(:user)
  end

  test "create with invalid name" do
    post :create, user: { name: '', password: 'password' }
    refute flash.empty?
    assert_template :new
    refute is_signed_in?
  end

  test "create with invalid password" do
    post :create, user: { name: @user.name, password: '' }
    refute flash.empty?
    assert_template :new
    refute is_signed_in?
  end

  test "create with valid credentials" do
    post :create, user: { name: @user.name, password: 'password' }
    assert is_signed_in?
  end

  test "create with case-insensitive name" do
    sign_in_as(@user.name.swapcase)
    # do not display a "name has changed" message
    assert flash.empty?
    assert is_signed_in?
  end

  test "create with updated name" do
    outdated_name = 'asdf'
    updated_name = @user.name
    # save incorrect name to database, to simulate outdated name
    @user.update_attribute(:name, outdated_name)

    refute_nil User.find_by(name: outdated_name)
    assert_nil User.find_by(name: updated_name)

    post :create, user: { name: updated_name, password: 'password' }
    assert is_signed_in?

    assert_nil User.find_by(name: outdated_name)
    refute_nil User.find_by(name: updated_name)

    refute flash.empty?
  end

  test "create while already signed-in" do
    sign_in_as @user
    post :create, user: { name: @user.name, password: 'password' }
    assert_response 422
  end

  test "destroy" do
    sign_in_as @user
    delete :destroy
    assert_redirected_to root_url
    refute is_signed_in?
  end
end
