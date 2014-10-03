require 'cases/helper'
require 'models/user'
require 'minitest/mock'

class SecureTokenTest < ActiveRecord::TestCase
  setup { @user = User.new(name: "kuldeep Aggarwal") }

  test "create a new user with unique secure_token" do
    assert_nil @user.token
    @user.save
    assert_not_nil @user.token
    assert !User.where(token: @user.token).where.not(id: @user.id).exists?
  end

  test "regenerate the secure token for the attribute" do
    old_key = @user.token
    @user.rekey_token!
    assert_not_equal @user.token, old_key
  end
end
