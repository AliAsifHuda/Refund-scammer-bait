require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup 
    @user = User1.new({username:"accounttestuser",password:'testpwd'})
    @user.save
    @account = Account.new({amount:5000,user1_id:@user.id,account_number:"123456"})
   
  end
  test "setup account valid?" do 
    assert @account.valid?
  end
  test "account number is not empty" do 
    @account.account_number = nil
    assert_not @account.valid?
  end

  test "account_number contains only digits" do
    @account.account_number ="12345D"
    assert_not @account.valid?
  end
  test "user id is not null/empty" do 
    @account.user1_id = nil 
    assert_not @account.valid?
  end
  test "account_number is not greater than 6 characters" do 
    @account.account_number = "1234567"
    assert_not @account.valid?
  end
  test "account_number is not less than 6 characters" do
    @account.account_number ="12345"
    assert_not @account.valid?
  end
  test "test account number is unique" do
  @duplicate_acc = @account.dup
  @account.save
  assert_not @duplicate_acc.valid?
  end


end
