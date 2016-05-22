require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "root" do
    get :root
    assert_response 200
    assert_template layout: 'layouts/application'
    assert_template 'root'
    assert_template partial: '_header'
    assert_template partial: '_messages'
    assert_template partial: '_footer'
  end

  test "about" do
    get :about
    assert_response 200
    assert_template layout: 'layouts/application'
    assert_template 'about'
  end
end
