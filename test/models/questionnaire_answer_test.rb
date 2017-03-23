require 'test_helper'

class QuestionnaireAnswerTest < ActiveSupport::TestCase
  test "question answers are valid with user and question" do
    test_answer = QuestionnaireAnswer.new(questionnaire_item: questionnaire_items(:one), character: characters(:one), answer: "a thing lol")
    assert test_answer.valid?
  end

  test "question answers not valid without question" do
    test_answer = QuestionnaireAnswer.new(character: characters(:one), answer: "more things")
    assert_not test_answer.valid?
  end

  test "question answers are not valid without character" do
    test_answer = QuestionnaireAnswer.new(questionnaire_item: questionnaire_items(:one), answer: "an answer")
    assert_not test_answer.valid?
  end

  test "question answers are not valid without an answer" do
    test_answer = QuestionnaireAnswer.new(questionnaire_item: questionnaire_items(:one), character: characters(:one))
    assert_not test_answer.valid?
  end
end
