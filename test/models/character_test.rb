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
    @character = User.new(username: 'ItsNickBarry', password: 'password')
          .characters.new(name: 'Nick Barry', gender: 'M')
  end

  test 'should be valid' do
    assert @character.valid?
  end

  test 'name should be present' do
    @character.name = ''
    assert_not @character.valid?
  end

  test 'name should be unique' do
    @character.name = characters(:markus_persson).name
    assert_not @character.valid?
  end

  test 'gender should be "M" or "F"' do
    @character.gender = ''
    assert_not @character.valid?
    @character.gender = 'A'
    assert_not @character.valid?
  end

  test 'user should be present' do
    assert_not_nil @character.user
  end

  test 'should be able to found fraction' do
    # TODO integration
  end
end
