require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Question should not be saved when blank" do
    question = Question.new
    assert_not question.save
  end
  
  test "Question should not be saved when no question type" do
    question = Question.new(content: "What is your question ?")
    assert_not question.save
  end

  test "Multiple question should not be saved when no choice" do
    question = Question.new(content: "What is your question ?")
    question.question_type = question_types(:multiple)
    assert_not question.save
  end 

  test "Selection question should not be saved when no choice" do
    question = Question.new(content: "What is your question ?")
    question.question_type = question_types(:selection)
    assert_not question.save
  end 

end
