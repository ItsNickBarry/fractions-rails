require 'test_helper'

class CharacterCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:carlmanneh)
  end

  test "submit valid character" do
    sign_in_as @user
    assert_difference 'Character.count' do
      post api_characters_url, character: { name: 'Carl Manneh', gender: 'M' }
      assert_response 200
    end
  end

  test "submit character while not signed in" do
    assert_not is_signed_in?
    assert_no_difference 'Character.count' do
      post api_characters_url, character: { name: 'Carl Manneh', gender: 'M' }
      assert_response 401
    end
  end

  test "submit character with duplicate name" do
    sign_in_as @user
    assert_no_difference 'Character.count' do
      post api_characters_url, character: { name: characters(:haakon_vii).name, gender: 'M' }
      assert_response 422
    end
  end

  test "submit character with case-insensitive duplicate name" do
    sign_in_as @user
    assert_no_difference 'Character.count' do
      post api_characters_url, character: { name: characters(:haakon_vii).name.swapcase, gender: 'M' }
      assert_response 422
    end
  end

  test "submit multiple characters" do
    # sign_in_as @user
    # assert_difference 'Character.count' do
    #   post api_characters_url, character: { name: 'Carl Manneh', gender: 'M' }
    #   assert_response 200
    # end
    # assert_no_difference 'Character.count' do
    #   post api_characters_url, character: { name: 'Karl Manneh', gender: 'M' }
    #   assert_response 422
    # end
    skip 'should limit number of creatable characters'
  end
end
