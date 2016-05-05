# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  fraction_id :integer          not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RegionTest < ActiveSupport::TestCase
  def setup
    @fraction = fractions(:visby)
    @region = Region.new(name: 'Axelsro', fraction: @fraction)
  end

  test "should be valid" do
    assert @region.valid?
  end

  test "should have name" do
    @region.name = ''
    refute @region.valid?
  end

  test "should have fraction" do
    @region.fraction = nil
    refute @region.valid?
  end

  test "name should be unique within scope of fraction" do
    @region.name = @fraction.regions.first.name
    refute @region.valid?
  end
end
