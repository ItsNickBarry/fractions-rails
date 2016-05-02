# == Schema Information
#
# Table name: fractions
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  ancestry     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  founder_id   :integer          not null
#  founder_type :string           not null
#

require 'test_helper'

class FractionTest < ActiveSupport::TestCase
  # associations provided by Ancestry gem not tested

  def setup
    @fraction = Fraction.create({
      name: 'Canada',
      founder: characters(:lydia_winters)
    })
    @child_fraction = Fraction.create({
      name: 'Ontario',
      founder: @fraction
    })
  end

  test "should be valid" do
    assert @fraction.valid?
    assert @child_fraction.valid?
  end

  test "name should be present" do
    @fraction.name = ''
    assert_not @fraction.valid?
  end

  test "name should be unique" do
    @fraction.name = @child_fraction.name
    assert_not @fraction.valid?
  end

  test "founder should be present" do
    @fraction.founder = nil
    assert_not @fraction.valid?
  end

  test "should have component objects" do
    assert @fraction.electorates.count > 0
    assert @fraction.positions.count > 0
    assert @fraction.regions.count > 0
  end
end
