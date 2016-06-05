# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  name             :string
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
    # use name with incorrect case, for case-correction tests
    @user = User.new(name: 'itsnickbarry', password: 'password')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ''
    refute @user.valid?
  end

  test "name with corrected case should be fetched before validation if uuid is nil" do
    assert_nil @user.uuid
    assert_equal 'itsnickbarry', @user.name
    @user.valid?
    assert_equal 'ItsNickBarry', @user.name
  end

  test "password should not match name" do
    @user.password = @user.name
    refute @user.valid?
  end

  test "password should not be too short" do
    @user.password = 'a' * 7
    refute @user.valid?
  end

  test "password digest should be present" do
    refute_nil @user.password_digest
  end

  test "uuid should be fetched before validation" do
    assert_nil @user.uuid
    assert @user.save!
    # uuid for ItsNickBarry, fetched from Mojang API
    assert_equal 'df5903fbd8e942dcbb3d82b085af5af1', @user.uuid
    @user.uuid = ''
    refute @user.valid?
  end

  test "uuid should be unique" do
    other_user = users(:notch)
    # must save to fetch uuid
    assert @user.save!
    @user.uuid = other_user.uuid
    refute @user.valid?
  end

  test "session token should be present" do
    refute_nil @user.session_token
  end

  test "session token should be unique" do
    other_user = users(:notch)
    @user.session_token = other_user.session_token
    refute @user.valid?
  end

  test "should be owner of current character" do
    character = characters(:haakon_vii)
    @user.current_character = character
    refute @user.valid?
  end

  test "valid user should set conflicting names equal to uuids" do
    conflicting_user = users(:notch)
    # use case-corrected name; case-unique names are not changed
    conflicting_user.update_attribute(:name, 'ItsNickBarry')

    assert @user.valid?

    assert_equal conflicting_user.uuid, User.find(conflicting_user.id).name
  end
end
