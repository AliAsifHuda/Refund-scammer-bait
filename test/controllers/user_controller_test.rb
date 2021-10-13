require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should not enter normal user1 new page1"do
    get new_user_url
    assert_redirected_to admin_path
  end

  test "should not enter normal user1 page 2"do
    post admin_login_url, params: {username:"admin123123", password:"kcl123"}
    assert_redirected_to admin_path
    get new_user_path
    assert_redirected_to admin_path
  end

  #test "should enter normal user1 new page"do
  #  post admin_login_url, params: {username: "admin1", password:"kcl123"}
  #  assert_redirected_to admin_panel_path
  #  get new_user_path
  #  assert_response :success
  #end

  test "should create normal user1"do
    post user_index_url, params: {username: "admin1234", password: "6666666"}
    assert_redirected_to '/admin'
  end

  test "should not create normal user1"do
    post admin_login_url, params: {username: "admin1", password: "kcl123"}
    assert_redirected_to admin_path
  end

end
