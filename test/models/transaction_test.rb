require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "transaction with valid description, type, account id & amount is valid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    user.save
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    transaction = Transaction.new({description: 'Some Company', transactionType: 'Deposit', amount: 30, account_id: account.id})
    assert transaction.valid?
  end

  test "transaction with valid description, type, negative account id & amount is valid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    user.save
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    transaction = Transaction.new({description: 'Some Company', transactionType: 'Deposit', amount: -30, account_id: account.id})
    assert transaction.valid?
  end

  test "transaction with invalid type amount, account id & description is invalid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    user.save
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    transaction = Transaction.new({description: '', transactionType: 'Not Deposit', amount: '', account_id: ''})
    assert_not transaction.valid?
  end

  test "transaction with valid description, type, account id & nil amount is invalid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    user.save
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    transaction = Transaction.new({description: 'Some Company', transactionType: 'Deposit', amount: '', account_id: account.id})
    assert_not transaction.valid?
  end

  test "transaction with valid description, amount, account id & nil type is invalid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    user.save
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    transaction = Transaction.new({description: 'Some Company', transactionType: '', amount: 30, account_id: account.id})
    assert_not transaction.valid?
  end

  #transaction type can only be Deposit and Withdrawl
  test "transaction with valid description, amount, account id & invalid type is invalid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    user.save
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    transaction = Transaction.new({description: 'Some Company', transactionType: 'Not Deposit', amount: 30, account_id: account.id})
    assert_not transaction.valid?
  end

  test "transaction with valid type, amount, account id & invalid description is invalid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    user.save
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    transaction = Transaction.new({description: '', transactionType: 'Deposit', amount: 30, account_id: account.id})
    assert_not transaction.valid?
  end

  test "transaction with valid description, type, amount & invalid account id is invalid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    user.save
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    transaction = Transaction.new({description: '', transactionType: 'Deposit', amount: 30, account_id: 9001})
    assert_not transaction.valid?
  end

  test "transaction with valid description, type, amount & usaved account id is invalid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    user.save
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    transaction = Transaction.new({description: '', transactionType: 'Deposit', amount: 30, account_id: account.id})
    assert_not transaction.valid?
  end

  test "transaction with valid description, type, amount & account id with unsaved user id is invalid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    account.save
    transaction = Transaction.new({description: '', transactionType: 'Deposit', amount: 30, account_id: account.id})
    assert_not transaction.valid?
  end

  test "transaction with valid description, type, amount, usaved account id & unsaved user id is invalid" do
    user = User1.new({username:"accounttestuser",password:'testpwd'})
    account = Account.new({amount:5000,user1_id:user.id,account_number:"123456"})
    transaction = Transaction.new({description: '', transactionType: 'Deposit', amount: 30, account_id: account.id})
    assert_not transaction.valid?
  end
end
