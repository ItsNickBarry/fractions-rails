require 'test_helper'

class RegionCreateTest < ActionDispatch::IntegrationTest
  test "create region" do
    region_name = 'Kingston House North'
    fraction = fractions(:norge)
    act_as characters(:haakon_vii)
    visit path_for fraction

    click_link 'Regions'

    click_button '+'
    fill_in 'region[name]', with: region_name
    click_button 'Submit'

    within '.list' do
      assert_text region_name
      click_link region_name
    end
    assert_text region_name
    assert_text "Region in #{ fraction.name }"
  end
end
