require 'test_helper'

class FractionCreateTest < ActionDispatch::IntegrationTest
  test "found fraction as character" do
    fraction_name = 'Pristina'
    act_as characters(:haakon_vii)
    visit root_path

    click_link @current_character.name

    within '#fraction-form' do
      fill_in 'fraction[name]', with: fraction_name
      click_button 'Submit'
    end

    within '#founded-fractions-list' do
      assert_text fraction_name
    end

    within '#fractions-list' do
      assert_text fraction_name

      click_link fraction_name
    end
    assert_text "founded by #{ @current_character.name }"
  end

  test "found fraction as fraction" do
    fraction_name = 'Liberia'
    parent = fractions(:united_states)
    act_as characters(:james_monroe)
    visit root_path

    click_link @current_character.name

    within '#fractions-list' do
      click_link parent.name
    end

    click_link 'Children'



    skip 'find executable button and click'



    within '#fraction-form' do
      fill_in 'fraction[name]', with: fraction_name
      click_button 'Submit'
    end

    within '#founded-fractions-list' do
      assert_text fraction_name
    end

    within '#children-list' do
      assert_text fraction_name

      click_link fraction_name
    end
    assert_text "founded by #{ parent.name }"
  end
end
