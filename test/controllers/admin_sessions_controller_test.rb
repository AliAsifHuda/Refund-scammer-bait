require 'test_helper'

class AdminSessionsControllerTest < ActionDispatch::IntegrationTest
test "should enter admin login page"do
  get admin_login_url
  assert_response :success
end

test"admin should login"do
  post admin_login_url, params: {username:"AdminTest", password:"kcl123"}
  assert_redirected_to admin_path
end

test"admin should not login"do
  post admin_login_url, params: {username:"AdminTest", password:"wrong_password"}
  assert_redirected_to admin_path
end

test "should enter admin panel page"do
#  post admin_login_url, params: {username:"AdminTest", password:"kcl123"}
#  get admin_panel_url
#  assert_response :success
end

test "should enter admin page"do
  get admin_url
  assert_response :success
end



end
