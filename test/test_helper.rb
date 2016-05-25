require 'simplecov'
SimpleCov.start 'rails' unless ENV['NO_COVERAGE']

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'capybara/rails'
require 'database_cleaner'

Capybara.default_driver = :webkit
DatabaseCleaner.strategy = :transaction
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true, slow_count: 5)]

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
end

module FixtureHelpers
  def ancestry_for *labels
    labels.map { |label| ActiveRecord::FixtureSet.identify label }.join('/')
  end
end
ActiveRecord::FixtureSet.context_class.include FixtureHelpers

class ActiveSupport::TestCase
  fixtures :all
end

class ActionController::TestCase
  def parse response
    @json = JSON.parse(response.body)
  end

  def act_as character
    raise 'Must have current user!' if @current_user.nil?
    character.update(user: @current_user)
    @current_user.update(current_character: character)
    @current_character = character
  end

  def sign_in_as(user, password = 'password')
    user.is_a?(User) || (user = User.where(<<-SQL).first)
      username = "#{ user }" COLLATE NOCASE
    SQL
    session[:session_token] = user.session_token
    @current_user = user
    @current_character = user.current_character
  end

  def is_signed_in?
    !!session[:session_token]
  rescue
    false
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  self.use_transactional_fixtures = false

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def is_signed_in?
    page.has_selector?('#sign-out') &&
    page.has_no_selector?('#sign-in')
  end

  def sign_in_as(user, password = 'password')
    user.is_a?(String) || (user = user.username)

    visit new_session_path

    within '#user-form' do
      fill_in 'user[username]', with: user
      fill_in 'user[password]', with: password
      click_button 'Submit'
    end
  end
end
