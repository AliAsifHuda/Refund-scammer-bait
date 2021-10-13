require 'test_helper'

class User1Test < ActiveSupport::TestCase
  def setup
    @user = User1.new({username: 'john', password:'foobar', password_confirmation: 'foobar'})
  end

  test "default user should be valid" do
    assert @user.valid?
  end

  test "user with non-matching passwords is invalid" do
    @user.password = 'foobar2'
    assert_not @user.valid?
  end

  test "username should be at least 4 characters" do
    @user.username = "x" * 3
    assert_not @user.valid?
  end

  test "username should be no more than 30 characters" do
    @user.username = "x" * 31
    assert_not @user.valid?
  end

  test "username should not be blank" do
    @user.username = " " * 4
    assert_not @user.valid?
  end

  test "username should not be unique" do
    duplicate_user = @user.dup
    duplicate_user.username = duplicate_user.username.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " "*6
    assert_not @user.valid?
  end

  test "password should have at least 6 characters" do
    @user.password = @user.password_confirmation = "x"*5
    assert_not @user.valid?
  end

end
