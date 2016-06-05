require 'test_helper'

class MojangApiConnectionTest < ActiveSupport::TestCase
  def uncache name
    # avoid Rails cache to ensure consistent code coverage
    Rails.cache.delete(MojangApiConnection.send(:profile_url, name))
  end

  test "profile given name should return hash of case-corrected name and uuid" do
    name = 'notch'
    uncache name
    response = MojangApiConnection.profile_given_name(name)
    assert response.is_a? Hash
    assert_equal 'Notch', response[:name]
    assert_equal '069a79f444e94726a5befca90e38aaf5', response[:uuid]
  end

  test "profile given name should return errors as strings" do
    # this test will fail if someone decides to register name 'mixmBhW40KZaA8a9'
    ['a' * 17, 'a' * 3, 'asdf^1234', 'with spaces', 'mixmBhW40KZaA8a9'].each do |name|
      uncache name
      response = MojangApiConnection.profile_given_name(name)
      assert_equal "Not a Minecraft name: #{ name }", response
    end
  end
end
