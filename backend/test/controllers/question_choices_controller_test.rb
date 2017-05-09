require 'test_helper'

class QuestionChoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_choice = question_choices(:one)
  end

  test "should get index" do
    get question_choices_url, as: :json
    assert_response :success
  end

  test "should create question_choice" do
    assert_difference('QuestionChoice.count') do
      post question_choices_url, params: { question_choice: { content: "This is my question", question_id: questions(:one).id } }, as: :json
    end
    assert_response 201
  end

  test "should show question_choice" do
    get question_choice_url(@question_choice), as: :json
    assert_response :success
  end

  test "should update question_choice" do
    patch question_choice_url(@question_choice), params: { content: "This is my question", question_id: questions(:one).id }, as: :json
    assert_response 200
  end

  test "should destroy question_choice" do
    assert_difference('QuestionChoice.count', -1) do
      delete question_choice_url(@question_choice), as: :json
    end

    assert_response 204
  end

end
