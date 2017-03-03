require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  test "challenges with names and descriptions are valid" do
    test_challenge = Challenge.new(name: "a", description: "b")
    assert test_challenge.valid?
  end

  test "challenges without names are not valid" do
    test_challenge = Challenge.new(description: "a")
    assert_not test_challenge.valid?
  end

  test "challenges without descriptions are not valid" do
    test_challenge = Challenge.new(name: "a")
    assert_not test_challenge.valid?
  end

  test "challenges must be unique" do
    one = Challenge.create(name: "a", description: "a")
    test_challenge = Challenge.create(name: "a", description: "a")
    assert_not test_challenge.valid?
  end
end
