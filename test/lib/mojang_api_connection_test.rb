require 'test_helper'

class MojangApiConnectionTest < ActiveSupport::TestCase
  def uncache username
    # avoid Rails cache to ensure consistent code coverage
    Rails.cache.delete(MojangApiConnection.send(:profile_url, username))
  end

  test "profile given username should return hash of case-corrected username and uuid" do
    username = 'notch'
    uncache username
    response = MojangApiConnection.profile_given_username(username)
    assert response.is_a? Hash
    assert_equal 'Notch', response[:username]
    assert_equal '069a79f444e94726a5befca90e38aaf5', response[:uuid]
  end

  test "profile given username should return errors as strings" do
    ['a' * 17, 'a' * 3, 'asdf^1234', 'with spaces'].each do |username|
      uncache username
      response = MojangApiConnection.profile_given_username(username)
      assert_equal "Not a Minecraft username: #{ username }", response
    end
  end
end
