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
  def setup
    # use username with incorrect case, for case-correction tests
    @user = User.new(username: 'itsnickbarry', password: 'password')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = ''
    assert_not @user.valid?
  end

  test "username with corrected case should be fetched before validation if uuid is nil" do
    assert_nil @user.uuid
    assert_equal 'itsnickbarry', @user.username
    @user.valid?
    assert_equal 'ItsNickBarry', @user.username
  end

  test "password should not match username" do
    @user.password = @user.username
    assert_not @user.valid?
  end

  test "password should not be too short" do
    @user.password = 'a' * 7
    assert_not @user.valid?
  end

  test "password digest should be present" do
    assert_not_nil @user.password_digest
  end

  test "uuid should be fetched before validation" do
    assert_nil @user.uuid
    assert @user.save!
    # uuid for ItsNickBarry, fetched from Mojang API
    assert_equal 'df5903fbd8e942dcbb3d82b085af5af1', @user.uuid
    @user.uuid = ''
    assert_not @user.valid?
  end

  test "uuid should be unique" do
    other_user = users(:notch)
    # must save to fetch uuid
    assert @user.save!
    @user.uuid = other_user.uuid
    assert_not @user.valid?
  end

  test "session token should be present" do
    assert_not_nil @user.session_token
  end

  test "session token should be unique" do
    other_user = users(:notch)
    @user.session_token = other_user.session_token
    assert_not @user.valid?
  end

  test "should be owner of current character" do
    skip "should own current character"
    # TODO integration?
  end

  test "valid user should set conflicting usernames equal to uuids" do
    conflicting_user = users(:notch)
    # use case-corrected username; case-unique usernames are not changed
    conflicting_user.update_attribute(:username, 'ItsNickBarry')

    assert @user.valid?

    assert_equal conflicting_user.uuid, User.find(conflicting_user.id).username
  end
end
