require 'test_helper'

class SignInTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:notch)
  end

  test "sign in with invalid credentials" do
    visit root_path
    click_link 'Sign In'

    within '#flash-messages' do
      refute_selector 'div'
    end

    within '#user-form' do
      fill_in 'user[name]', with: @user.name
      fill_in 'user[password]', with: 'wrong password'
      click_button 'Submit'
    end

    within '#flash-messages' do
      assert_text 'The combination of name and password you have provided is invalid.'
    end

    visit root_path

    within '#flash-messages' do
      refute_selector 'div'
    end
  end

  test "sign in with valid credentials and sign out" do
    sign_in_as(@user)
    click_link 'Sign Out'
    refute is_signed_in?
  end

  test "sign in with case-insensitive name" do
    sign_in_as(@user.name.swapcase)
    # do not display a "name has changed" message
    within '#flash-messages' do
      refute_selector 'div'
    end
    assert is_signed_in?
  end

  test "sign in with updated name" do
    outdated_name = 'asdf'
    updated_name = @user.name
    # save incorrect name to database, to simulate outdated name
    @user.update_attribute(:name, outdated_name)

    sign_in_as(updated_name)
    assert is_signed_in?

    assert_text updated_name
    assert_no_text outdated_name

    within '#flash-messages' do
      assert_text "Your name appears to have changed; you are now signed in as #{ updated_name }."
    end
  end

  test "signed-out user should have 'sign-up' and 'sign-in' links" do
    visit root_path
    assert page.has_selector? '#sign-up'
    assert page.has_selector? '#sign-in'
    assert page.has_no_selector? '#sign-out'
  end

  test "signed-in user should have 'sign-out' link" do
    sign_in_as @user
    assert page.has_no_selector? '#sign-up'
    assert page.has_no_selector? '#sign-in'
    assert page.has_selector? '#sign-out'
  end

  test "sign out" do
    sign_in_as @user
    assert is_signed_in?
    click_link 'Sign Out'
    refute is_signed_in?
  end
end
