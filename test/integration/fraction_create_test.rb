require 'test_helper'

class FractionCreateTest < ActionDispatch::IntegrationTest
  test "found fraction as character" do
    fraction_name = 'Svalbard'
    act_as characters(:haakon_vii)
    visit root_path

    click_link @current_character.name

    click_button '+'
    fill_in 'fraction[name]', with: fraction_name
    click_button 'Submit'

    within '#founded-fractions-list' do
      assert_text fraction_name
      click_link fraction_name
    end
    assert_text fraction_name
  end

  test "found fraction as fraction" do
    fraction_name = 'Liberia'
    parent_name = fractions(:united_states).name
    act_as characters(:james_monroe)
    visit root_path

    click_link @current_character.name

    within '#fractions-list' do
      click_link parent_name
    end

    click_link 'Children'

    within '.tab-content' do
      click_button '+'
      fill_in 'fraction[name]', with: fraction_name
      click_button 'Submit'
    end

    within '.list' do
      assert_text fraction_name
      click_link fraction_name
    end
    assert_text fraction_name
  end
end
