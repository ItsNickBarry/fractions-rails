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
  # associations provided by Ancestry gem are presumed to work

  def setup
    @fraction = Fraction.create(name: 'Svalbard', founder: fractions(:norge))
  end

  test "should be valid" do
    assert @fraction.valid?
  end

  test "name should be present" do
    @fraction.name = ''
    refute @fraction.valid?
  end

  test "name should be unique" do
    @fraction.name = fractions(:sverige).name
    refute @fraction.valid?
  end

  test "name should be unique, insensitive of case" do
    @fraction.name = fractions(:sverige).name.swapcase
    refute @fraction.valid?
  end

  test "founder should be present" do
    @fraction.founder = nil
    refute @fraction.valid?
  end

  test "should have component objects" do
    assert @fraction.electorates.count > 0
    assert @fraction.positions.count > 0
    assert @fraction.regions.count > 0
  end
end
