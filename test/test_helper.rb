ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true, slow_count: 5)]

module FixtureHelpers
  def ancestry_for *labels
    labels.map { |label| ActiveRecord::FixtureSet.identify label }.join('/')
  end
end

ActiveRecord::FixtureSet.context_class.include FixtureHelpers

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_signed_in?
    !!session[:session_token]
  rescue
    false
  end

  def sign_in_as(user, password = 'password')
    username = user.is_a?(User) ? user.username : user
    post session_path, user: { username: username, password: password }
  end
end
