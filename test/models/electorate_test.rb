# == Schema Information
#
# Table name: electorates
#
#  id          :integer          not null, primary key
#  fraction_id :integer          not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ElectorateTest < ActiveSupport::TestCase
  def setup
    @fraction = fractions(:uusimaa)
    @electorate = Electorate.new(name: 'Regional Council', fraction: @fraction)
  end

  test "should be valid" do
    assert @electorate.valid?
  end

  test "should have name" do
    @electorate.name = ''
    assert_not @electorate.valid?
  end

  test "should have fraction" do
    @electorate.fraction = nil
    assert_not @electorate.valid?
  end

  test "name should be unique within scope of fraction" do
    @electorate.name = @fraction.electorates.first.name
    assert_not @electorate.valid?
  end
end
