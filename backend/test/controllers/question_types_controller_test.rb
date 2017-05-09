require 'test_helper'

class QuestionTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_type = question_types(:multiple)
  end

  test "should get index" do
    get question_types_url, as: :json
    assert_response :success
  end

  test "should create question_type" do  
    assert_difference('QuestionType.count') do
      post question_types_url, params: { question_type: { content: "Open" } }, as: :json
    end
    assert_response 201
  end

  test "should show question_type" do
    get question_type_url(@question_type), as: :json
    assert_response :success
  end

  test "should update question_type" do
    patch question_type_url(@question_type), params: { question_type: { content: "Open" } }, as: :json
    assert_response 200
  end

  test "should not destroy question_type" do
    delete question_type_url(@question_type), as: :json
    assert_response 405
  end
  
end
