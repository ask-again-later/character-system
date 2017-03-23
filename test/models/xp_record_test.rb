require 'test_helper'

class XpRecordTest < ActiveSupport::TestCase
  test "xp records are valid with character and amount" do
    xp = XpRecord.new(character: characters(:one), amount: 1)
    assert xp.valid?
  end

  test "xp records without character are invalid" do
    xp = XpRecord.new(amount: 1)
    assert_not xp.valid?
  end

  test "xp records without amount are invalid" do
    xp = XpRecord.new(character: characters(:one))
    assert_not xp.valid?
  end
end
