require 'test_helper'

class VisitorTest < ActionDispatch::IntegrationTest
  test "visitor should be able to login with valid credentials" do
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

  test "visitor should be able to login with valid credentials and view transaction" do
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
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    get '/visitors/' + account.id.to_s + '/transactions'
    assert_template 'visitors/transactions'
  end

  test "visitor should be able to login with valid credentials and make transaction" do
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
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    @transaction = Transaction.new(description: 'Some company', amount:'10', transactionType: 'Deposit', account_id: account.id)
    @transaction.save
    post '/visitors/' + account.id.to_s + '/create_transaction', params: {transaction: {description: @transaction.description, amount: @transaction.amount, transactionType: @transaction.transactionType, account_id: @transaction.account_id}}
  end

  test "visitor should be able to login with valid credentials and make transaction which updates the account balance" do
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
    @account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    @account.save
    post '/accounts/create', params: {account: {amount: @account.amount, user1_id: @account.user1_id, account_number: @account.account_number}}
    @transaction = Transaction.new(description: 'Some company', amount:10, transactionType: 'Deposit', account_id: @account.id)
    @transaction.save
    post '/visitors/' + @account.id.to_s + '/create_transaction', params: {transaction: {description: @transaction.description, amount: @transaction.amount, transactionType: @transaction.transactionType, account_id: @transaction.account_id}}
    get '/visitors/' + @account.id.to_s + '/new_transaction', params: {transaction: {description: @transaction.description, amount: @transaction.amount, transactionType: @transaction.transactionType, account_id: @transaction.account_id}}
    @account.amount = @account.amount - 10
    get '/visitors'
    assert @account.amount =4090
  end
end
