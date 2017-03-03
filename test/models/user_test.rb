require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "A user with all valid fields should be valid" do
    test_user = User.new(email: "testing@testing.com", password: "welcome",
                         password_confirmation: "welcome", name: "Test plz")
    assert test_user.valid?
  end

  test "A user without an email should be invalid" do
    test_user = User.new(password: "welcome",
                         password_confirmation: "welcome", name: "Test plz")
    assert_not test_user.valid?
  end

  test "A user without a password should be invalid" do
    test_user = User.new(email: "testing@testing.com",
                         password_confirmation: "welcome", name: "Test plz")
    assert_not test_user.valid?
  end

  test "A user without a matching password confirmation should be invalid" do
    test_user = User.new(email: "testing@testing.com", password: "welcome",
                         password_confirmation: "not matching", name: "Test plz")
    assert_not test_user.valid?
  end
end
