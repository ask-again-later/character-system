require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  test "characters are valid with an associated user" do
    test_char = Character.new(user: users(:user_one))
    assert test_char.valid?
  end

  test "characters without an associated user are not valid" do
    test_char = Character.new
    assert_not test_char.valid?
  end
end
