require 'test_helper'

class AdvantageTest < ActiveSupport::TestCase
  test "advantages are valid with name and description" do
    test_advantage = Advantage.new(name: "Lay on Hands", description: "Heal someone")
    assert test_advantage.valid?
  end

  test "advantages are not valid without a name" do
    test_advantage = Advantage.new(description: "Who knows!!!")
    assert_not test_advantage.valid?
  end

  test "advantages are not valid without a description" do
    test_advantage = Advantage.new(name: "No description")
    assert_not test_advantage.valid?
  end

  test "advantages must have unique names" do
    first = Advantage.create(name: "a", description: "b")
    second = Advantage.new(name: "a", description: "c")
    assert_not second.valid?
  end
end
