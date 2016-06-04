require 'test_helper'

class ElectorateCreateTest < ActionDispatch::IntegrationTest
  test "create electorate" do
    electorate_name = 'London Cabinet'
    fraction = fractions(:norge)
    act_as characters(:haakon_vii)
    visit path_for fraction

    click_link 'Electorates'

    within '.tab-content' do
      click_button '+'
      fill_in 'electorate[name]', with: electorate_name
      click_button 'Submit'
    end

    within '.list' do
      assert_text electorate_name
      click_link electorate_name
    end
    assert_text electorate_name
    assert_text "Electorate in #{ fraction.name }"
  end
end
