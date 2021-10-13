require 'test_helper'

class AdminUsersLoginTest < ActionDispatch::IntegrationTest
  ##logged in tests
  test "admin login with valid credentials" do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
  end

  test "logged in admin can navigate to panel" do
      user = AdminUser.new({username:"admin_int",password:"kcl123"})
      user.save
      post '/admin/login', params: { username: "admin_int", password:"kcl123"}
      assert is_admin_logged_in?
      get "/admin/panel"
      assert_response :success
  end

  ##not logged in tests
  test "admin login with invalid credentials" do
      get admin_url
      assert_response :success
      assert_not is_admin_logged_in?
      assert_template "adminPage"
      post '/admin/login', params: { username: "admin_int", password:"kcl123"}
      assert_redirected_to '/admin'
      follow_redirect!
      assert_not is_admin_logged_in?
      assert_template 'adminPage'
  end

  test "not logged in cant access panel"do
      get '/admin'
      assert_not is_admin_logged_in?
      get "/admin/panel"
      assert_redirected_to '/admin'
  end

  test "not logged and atleast one admin user in db , cant access new admin page" do
      ## need to save one user, if no admin users in db page is open to public
      user = AdminUser.new({username:"admin_int",password:"kcl123"})
      user.save
      get '/admin'
      assert_not is_admin_logged_in?
      get '/admin_users/new'
      assert_redirected_to '/admin'
  end

  #logout test
  test "once logout button click admin is no longer logged in " do
      user = AdminUser.new({username:"admin_int",password:"kcl123"})
      user.save
      post '/admin/login', params: { username: "admin_int", password:"kcl123"}
      get '/admin/logout'
      assert_redirected_to '/admin'
      assert_not is_admin_logged_in?
  end

  test 'admin should be able to create new admin users' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    get '/admin_users/new'
    assert_response :success
    assert_template 'admin_users/new'
  end

  test 'admin should be able to create new normal users' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    get '/admin/panel/user/new?'
    assert_response :success
    assert_template 'user/new'
  end

  test 'admin should be able to view user' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get '/admin/panel/user/' + user.id.to_s
    assert_response :success
    assert_template 'user/show'
  end

  test 'admin should be able to view user and create a new account for the user' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get '/admin/panel/user/' + user.id.to_s
    assert_response :success
    assert_template 'user/show'
    assert_difference('Account.count' , 1) do
      account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
      account.save
    end
    assert_template 'user/show'
  end

  test 'admin should be able to view user and create a new account for the user and then delete it' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get '/admin/panel/user/' + user.id.to_s
    assert_response :success
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    get '/admin/panel/user/' + user.id.to_s + '/' +account.id.to_s
    assert_response :success
    assert_template 'accounts/admin_view'
    assert_difference('Account.count' , -1) do
      get '/admin/panel/user/' + user.id.to_s + '/' +account.id.to_s + '/delete'
    end
  end

  test 'admin should be able to view user and create a new account for the user and view its transactions' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get '/admin/panel/user/' + user.id.to_s
    assert_response :success
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    get '/admin/panel/user/' + user.id.to_s + '/' +account.id.to_s
    assert_response :success
    assert_template 'accounts/admin_view'
  end

  test 'admin should be able to view user and create a new account for the user and create transaction' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get '/admin/panel/user/' + user.id.to_s
    assert_response :success
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    get '/admin/panel/user/' + user.id.to_s + '/' +account.id.to_s
    assert_response :success
    assert_template 'accounts/admin_view'
    assert_difference('Transaction.count' , 1) do
      transaction = Transaction.new({description: 'Some Company', transactionType: 'Deposit', amount: 30, account_id: account.id})
      transaction.save
    end
  end

  test 'admin should be able to view user and create a new account for the user and create transaction and delete it' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get '/admin/panel/user/' + user.id.to_s
    assert_response :success
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    get '/admin/panel/user/' + user.id.to_s + '/' +account.id.to_s
    assert_response :success
    assert_template 'accounts/admin_view'
    transaction = Transaction.new({description: 'Some Company', transactionType: 'Deposit', amount: 30, account_id:account.id})
    transaction.save
    assert_difference('Transaction.count' , -1) do
     transaction.delete
    end
    assert_response :success
  end
  
  test 'admin should be able to view user and create a new account for the user and create transaction which increase account balance' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get '/admin/panel/user/' + user.id.to_s
    assert_response :success
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    get '/admin/panel/user/' + user.id.to_s + '/' + account.id.to_s
    assert_response :success
    assert_template 'accounts/admin_view'
    transaction = Transaction.new({description: 'Some Company', transactionType: 'Deposit', amount: 100, account_id: account.id})
    transaction.save
    account.amount = account.amount + transaction.amount
    assert account.amount == 5100
  end

  test 'admin should be able to view user and create a new account for the user and create transaction which decreses account balance' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get '/admin/panel/user/' + user.id.to_s
    assert_response :success
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    get '/admin/panel/user/' + user.id.to_s + '/' + account.id.to_s
    assert_response :success
    assert_template 'accounts/admin_view'
    transaction = Transaction.new({description: 'Some Company', transactionType: 'Deposit', amount: -100, account_id: account.id})
    transaction.save
    account.amount = account.amount + transaction.amount
    assert account.amount == 4900
  end

  #the new transaction created is then delteted this should means balance before cresting transaction and after deleting it should be the same
  test 'admin should be able to view user and create a new account for the user and create transaction and then deltete it which has n effect on account balance' do
    user = AdminUser.new({username:"admin_int",password:"kcl123"})
    user.save
    post '/admin/login', params: { username: "admin_int", password:"kcl123"}
    assert is_admin_logged_in?
    get "/admin/panel"
    assert_response :success
    assert_template 'admin_sessions/_admin_show_users'
    user = User1.new({username: "jane", password: "password1", password_confirmation:"password1"})
    user.save
    get '/admin/panel/user/' + user.id.to_s
    assert_response :success
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    get '/admin/panel/user/' + user.id.to_s + '/' + account.id.to_s
    assert_response :success
    assert_template 'accounts/admin_view'
    transaction = Transaction.new({description: 'Some Company', transactionType: 'Deposit', amount: 100, account_id: account.id})
    transaction.save
    account.amount = account.amount + transaction.amount
    assert account.amount == 5100
    account.amount = account.amount - transaction.amount
    transaction.delete
    assert account.amount = 5000
  end
end
