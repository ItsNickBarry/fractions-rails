require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test "sign up with invalid credentials" do
    visit root_path
    click_link 'Sign Up'

    within '#flash-messages' do
      refute_selector 'div'
    end

    within '#user-form' do
      fill_in 'user[name]', with: 'itsnickbarry'
      fill_in 'user[password]', with: ''
      click_button 'Submit'
    end

    within '#flash-messages' do
      assert_text 'Password is too short'
    end

    within '#user-form' do
      fill_in 'user[name]', with: 'a' * 17
      fill_in 'user[password]', with: 'password'
      click_button 'Submit'
    end

    within '#flash-messages' do
      assert_text 'Not a Minecraft name'
    end

    visit root_path

    within '#flash-messages' do
      refute_selector 'div'
    end
  end

  test "sign up with valid, case-insensitive credentials" do
    visit root_path
    click_link 'Sign Up'

    within '#user-form' do
      fill_in 'user[name]', with: 'itsnickbarry'
      fill_in 'user[password]', with: 'password'
      click_button 'Submit'
    end

    skip 'assert not activated'
    skip 'assert activation instructions page'
  end
end
