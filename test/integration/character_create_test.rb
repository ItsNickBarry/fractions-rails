require 'test_helper'

class CharacterCreateTest < ActionDispatch::IntegrationTest
  def setup
    sign_in_as users(:carlmanneh)
  end

  test "submit valid characters" do
    click_link 'Account'

    within '#character-form' do
      fill_in 'character[name]', with: 'Carl Manneh'
      choose 'M'
      click_button 'Submit'
    end

    within '#characters-list' do
      assert_text 'Carl Manneh'
    end

    within '#character-form' do
      fill_in 'character[name]', with: 'Karl Manneh'
      choose 'M'
      click_button 'Submit'
    end

    skip 'should limit number of creatable characters'

    skip 'should display error'

    within '#characters-list' do
      assert_no_text 'Karl Manneh'
    end

    skip 'should have link to current_user page'
  end

  test 'submit characters with duplicate names' do
    persisted_name = characters(:haakon_vii).name

    click_link 'Account'

    within '#character-form' do
      fill_in 'character[name]', with: persisted_name
      choose 'M'
      click_button 'Submit'
    end

    within '#characters-list' do
      assert_no_text persisted_name
    end

    within '#character-form' do
      fill_in 'character[name]', with: persisted_name.swapcase
      choose 'M'
      click_button 'Submit'
    end

    within '#characters-list' do
      assert_no_text persisted_name.swapcase
    end

    skip 'assert error messages'
  end
end
