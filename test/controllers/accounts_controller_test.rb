require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get accounts_new_url
    assert_redirected_to '/admin'
  end

  test "should get create" do
    get accounts_create_url
    assert_redirected_to '/admin'
  end

  test "redirect to admin if not logged in"do
    get accounts_new_url
    assert_redirected_to admin_url
  end

  test "redirect to admin panel user if logged in"do
    post admin_login_url, params: {username:"AdminTest", password:"kcl123"}
    get accounts_create_url
    assert_redirected_to "/admin"
    assert_equal Transaction.count, 0
    assert_equal Account.count, 0
  end

  test "get admin view"do
    post admin_login_url, params: {username:"AdminTest", password:"kcl123"}
    get accounts_create_url
    assert_redirected_to "/admin"
    get "/admin"
    assert_response :success
  end

end
