ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true, slow_count: 5)]

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_signed_in?
    !!session[:session_token]
  end

  def sign_in_as(user, password = 'password')
    username = user.is_a?(User) ? user.username : user
    post session_path, user: { username: username, password: password }
  end

  def persisted_user
    users(:notch)
  end

  def mojang_staff
    [
      users(:dinnerbone),
      users(:jeb_),
      users(:minecraftchick),
      users(:notch),
      users(:xlson)
    ]
  end
end
