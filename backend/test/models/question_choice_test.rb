require 'test_helper'

class QuestionChoiceTest < ActiveSupport::TestCase
  test "QuestionChoice should not be saved when blank" do
    question_choice = QuestionChoice.new
    assert_not question_choice.save
  end
  
  test "QuestionChoice should not be saved when no question type" do
    question_choice = QuestionChoice.new(content: "This is my answer")
    assert_not question_choice.save
  end
end
