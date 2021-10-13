require 'test_helper'

class User1sLoginTest < ActionDispatch::IntegrationTest
  test "login with valid credentials" do
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get login_url
    assert_response :success
    assert_not is_logged_in?
    assert_template 'sessions/new'
    post login_url, params: {session: {username: 'jane', password:'password1'}}
    assert_redirected_to '/visitors'
    follow_redirect!
    assert_template 'visitors/index'
    assert is_logged_in?
  end

  test "login with invalid credentials" do
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get login_url
    assert_response :success
    assert_not is_logged_in?
    assert_template 'sessions/new'
    post login_url, params: {session: {username: 'jane', password:'foobar'}}
    assert_response :success
    assert_template 'sessions/new'
    assert_not is_logged_in?
  end

  test "user can navigate to menu page after login" do
    user = User1.new({username: "jane", password:"password1", password_confirmation:"password1"})
    user.save
    post login_url, params: {session: {username: 'jane', password:'password1'}}
    assert is_logged_in?
    get "/visitors"
    assert_response :success
  end


end
