require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get root" do
    get :root
    assert_response :success
    assert_template layout: 'layouts/application'
    assert_template partial: '_header'
    assert_template partial: '_messages'
    assert_template partial: '_footer'
  end

  test "header should include sign-in and sign-up links" do
    get :root
    assert_select 'header' do
      assert_select 'a', 'Sign In'
      assert_select 'a', 'Sign Up'
    end
  end
end
