# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  username             :string
#  uuid                 :string           not null
#  password_digest      :string           not null
#  session_token        :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  current_character_id :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should fetch uuid' do
    user = User.create(username: 'itsnickbarry', password: 'password')
    assert_equal 'df5903fbd8e942dcbb3d82b085af5af1', user.uuid
  end

  test 'should update username case' do
    user = User.create(username: 'itsnickbarry', password: 'password')
    assert_equal 'ItsNickBarry', user.username
  end
end
