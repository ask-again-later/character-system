require 'test_helper'

class QuestionnaireAnswerTest < ActiveSupport::TestCase
  test "question answers are valid with user and question" do
    test_answer = QuestionnaireAnswer.new(questionnaire_item: questionnaire_items(:one), character: characters(:one), answer: "a thing lol")
    assert test_answer.valid?
  end
end
