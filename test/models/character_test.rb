# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string           not null
#  gender     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'ItsNickBarry', password: 'password')
    @character = @user.characters.new(name: 'Nick Barry', gender: 'M')
  end

  test "should be valid" do
    assert @character.valid?
  end

  test "name should be present" do
    @character.name = ''
    refute @character.valid?
  end

  test "name should be unique" do
    @character.name = characters(:markus_persson).name
    refute @character.valid?
  end

  test "name should be unique, insensitive of case" do
    @character.name = characters(:markus_persson).name.swapcase
    refute @character.valid?
  end

  test "gender should be 'M' or 'F'" do
    @character.gender = ''
    refute @character.valid?
    @character.gender = 'A'
    refute @character.valid?
  end

  test "should be able to found one fraction right away" do
    @character.save!
    assert @character.can_found_fraction?
    @character.founded_fractions.create(name: 'a fraction')
    refute @character.can_found_fraction?
  end

  test "should be set to user's default character if not already set" do
    assert_nil @user.current_character
    @character.save!
    assert_equal @character, @user.current_character
  end
end
