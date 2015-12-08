require 'test_helper'

class MojangApiConnectionTest < ActiveSupport::TestCase
  test 'profile given username should return hash of case-corrected username and uuid' do
    response = MojangApiConnection.profile_given_username('notch')
    assert response.is_a? Hash
    assert_equal 'Notch', response[:username]
    assert_equal '069a79f444e94726a5befca90e38aaf5', response[:uuid]
  end

  test 'profile given username should return errors as strings' do
    ['a' * 17, 'a' * 3, 'asdf^1234', 'with spaces'].each do |username|
      response = MojangApiConnection.profile_given_username(username)
      assert response.is_a? String
    end
  end

  # test 'profile given username should raise exception for invalid username' do
  #   ['a' * 17, 'a' * 3, 'asdf^1234', 'name with spaces'].each do |username|
  #     assert_raise { response = MojangApiConnection.profile_given_username(username) }
  #   end
  # end
end
