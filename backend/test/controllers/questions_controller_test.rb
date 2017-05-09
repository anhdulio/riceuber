require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question = questions(:one)
  end

  test "should get index" do
    get questions_url, as: :json
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      question_type = question_types(:selection)
      choices = ["Option 1","Option 2", "Option 3"]
      post questions_url, params: { question: { content: "This is a question"}, question_type: "selection" , question_choices: choices }, as: :json
    end
    assert_response 201
  end
  
  test "should create open question with no choice" do
    assert_difference('Question.count') do
      post questions_url, params: { question: { content: "This is a question"}, question_type: "open"}, as: :json
    end
    assert_response 201
  end

  test "should not create question without question type" do
    question_type = question_types(:selection)
    choices = ["Option 1","Option 2", "Option 3"]
    post questions_url, params: { question: { content: "This is a question"}, question_choices: choices }, as: :json
    assert_response 422
  end

  test "should not create selection question with no choice" do
    question_type = question_types(:selection)
    choices = ["Option 1","Option 2", "Option 3"]
    post questions_url, params: { question: { content: "This is a question"}, question_type: "selection"}, as: :json
    assert_response 422
  end

  test "should show question" do
    get question_url(@question), as: :json
    assert_response :success
  end

  test "should update question" do
    patch question_url(@question), params: { question: { content: "This is updated question" } }, as: :json
    assert_equal "This is updated question", @question.reload.content
  end

  test "should update question with question type" do
    patch question_url(@question), params: { question: {content: @question.content}, question_type: "selection" }, as: :json
    assert_equal "selection", @question.reload.question_type.content
  end

  test "should update question with new question type" do
    assert_difference('QuestionType.count') do
      patch question_url(@question), params: { question: {content: @question.content}, question_type: "open" }, as: :json
    end
    assert_equal "open", @question.reload.question_type.content
  end

  test "should update question with question choices" do
    assert_changes('QuestionChoice.count') do
      patch question_url(@question), params: { question: {content: @question.content}, question_choices: ["Option 1", "Option 2"] }, as: :json
    end
    assert_equal "Option 1", @question.reload.question_choices[0].content
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete question_url(@question), as: :json
    end

    assert_response 204
  end
end
