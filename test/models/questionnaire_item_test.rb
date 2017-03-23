require 'test_helper'

class QuestionnaireItemTest < ActiveSupport::TestCase
  test "questions are valid with a question" do
    test_q = QuestionnaireItem.new(question: "what is what?")
    assert test_q.valid?
  end

  test "questions are not valid without a question" do
    test_q = QuestionnaireItem.new
    assert_not test_q.valid?
  end
end
