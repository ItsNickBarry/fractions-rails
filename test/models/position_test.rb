# == Schema Information
#
# Table name: positions
#
#  id          :integer          not null, primary key
#  fraction_id :integer          not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  def setup
    @fraction = fractions(:uppland)
    @position = Position.new(name: 'Comptroller', fraction: @fraction)
  end

  test "should be valid" do
    assert @position.valid?
  end

  test "should have name" do
    @position.name = ''
    assert_not @position.valid?
  end

  test "should have fraction" do
    @position.fraction = nil
    assert_not @position.valid?
  end

  test "name should be unique within scope of fraction" do
    @position.name = @fraction.positions.first.name
    assert_not @position.valid?
  end
end
