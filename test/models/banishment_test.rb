# == Schema Information
#
# Table name: banishments
#
#  id           :integer          not null, primary key
#  character_id :integer          not null
#  fraction_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class BanishmentTest < ActiveSupport::TestCase

  def setup
    # https://en.wikipedia.org/wiki/Haakon_VII_of_Norway#Government_in_exile
    @fraction = fractions(:oslo)
    @character = characters(:haakon_vii)
    # 1940
    @banishment = Banishment.new(fraction: @fraction, character: @character)
  end

  test "should be valid" do
    assert @banishment.valid?
  end

  test "should have character" do
    @banishment.character = nil
    refute @banishment.valid?
  end

  test "should have fraction" do
    @banishment.fraction = nil
    refute @banishment.valid?
  end

  test "should have expiration date" do
    skip 'assert expiration date'
  end

  test "character should be unique within scope of fraction" do
    @banishment.save!
    duplicate_banishment = Banishment.new(
      fraction: @banishment.fraction,
      character: @banishment.character
    )
    refute duplicate_banishment.valid?
  end

  test "should prevent invitation to fraction and descendants" do
    skip 'assert invitation prevented'
  end

  test "should remove character from positions in fraction and descendants" do
    descendant_fraction = fractions(:akershus)
    refute_nil @fraction.characters.find_by name: @character.name
    refute_nil descendant_fraction.characters.find_by name: @character.name
    @banishment.save!
    assert_nil @fraction.characters.find_by name: @character.name
    assert_nil descendant_fraction.characters.find_by name: @character.name
  end

  test "should not remove character from positions in ancestor fraction" do
    parent_fraction = fractions(:norge)
    @banishment.save!
    refute_nil parent_fraction.characters.find_by name: @character.name
  end
end
