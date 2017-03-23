require 'test_helper'

class TrueSelfTest < ActiveSupport::TestCase
  test "true self is valid with a name" do
    test_self = TrueSelf.new(name: "what is the measure of a person")
    assert test_self.valid?
  end

  test "true self is not valid without a name" do
    test_self = TrueSelf.new
    assert_not test_self.valid?
  end
end
