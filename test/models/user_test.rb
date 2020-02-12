require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: 'username', email: 'user@ex.cc')
  end
  
  test 'username should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

   test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test 'username should be not too long' do
    @user.name = 'fuck'*10
    assert_not @user.valid?
  end

  test 'username should not be duplicate' do
    duplicate_user = @user.dup
    duplicate_user.name = @user.name.upcase #test for case sensitivity.
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase #test for case sensitivity.
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email should be saved in downcase' do
    mixed_case_email = "FoO@bAr.roBoMoNK"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
