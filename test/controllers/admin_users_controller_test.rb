require 'test_helper'

class AdminUsersControllerTest < ActionDispatch::IntegrationTest
  test "should enter admin_users new page"do
    post admin_login_url, params: {username:"AdminTest", password: "kcl123"}
    get new_admin_user_url
    assert_response :success
  end

  test "should create admin_users"do
    post admin_users_url, params: {admin_user:{username:"AdminTest1", password:"kcl123"}}
    assert_redirected_to admin_url
    assert_equal AdminUser.count, 1
  end

end
