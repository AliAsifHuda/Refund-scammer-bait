require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
test "should get new" do
  get login_url
  assert_response :success
end

test "should enter login page"do
  get login_url
  assert_response :success
end

test "should not login"do
  post login_url, params: {session: {username:"user1", password: "111111"}}
  assert_response :success
end

test "should login"do
  post login_url, params: {session: {username:"user1", password: "123456"}}
  assert_response :success
end

test "should logout"do
  post login_url, params: {session: {username:"user1", password: "123456"}}
  assert_response :success
  get logout_url
  assert_redirected_to root_path
end

end
