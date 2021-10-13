require 'test_helper'

class AdminUserTest < ActiveSupport::TestCase

  #setup #
  def setup 
    @user = AdminUser.new({username:"admintest",password:'testpwd'})
  end
  test "setup user valid?" do 
    assert @user.valid?
  end

  # tests on password #
  test "password atleast 4 characters" do 
    @user.password = "xyz"
    assert_not @user.valid?
  end
  
  test "admin user password not blank" do 
    @user.password = ' ' *5
    assert_not @user.valid?
  end
  test "password no greater than 15 characters" do
    @user.password = 'f' *16
    assert_not @user.valid?
  end

  #test on username#
  test "username should be unique" do 
    duplicate_user = @user.dup
    duplicate_user.username = duplicate_user.username.upcase 
    @user.save
    assert_not duplicate_user.valid?
  end

  test "username should be lowercase after saving" do
    @user.username = "ALLUPCASE"
    @user.save
    assert @user.username == "allupcase"
   
  end

  test "username atleast 4 characters" do
    @user.username = "fff"
    assert_not @user.valid?
  end

  test "username not more than 15 characters " do 
    @user.username = "f" * 16
    assert_not @user.valid?
  end

  test "username not blank" do 
      @user.username = " "  *4
      assert_not @user.valid?
  end
end
