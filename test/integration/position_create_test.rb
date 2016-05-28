require 'test_helper'

class PositionCreateTest < ActionDispatch::IntegrationTest
  test "create position" do
    position_name = 'Minister of Trade, Shipping, Industry, Crafts and Fisheries'
    fraction = fractions(:norge)
    act_as characters(:haakon_vii)
    visit path_for fraction

    click_link 'Positions'

    click_button '+'
    fill_in 'position[name]', with: position_name
    click_button 'Submit'

    within '.list' do
      assert_text position_name
      click_link position_name
    end
    assert_text position_name
    assert_text "Position in #{ fraction.name }"
  end
end
