require 'test_helper'

class QuestionTypeTest < ActiveSupport::TestCase

  test "type should not be saved when blank" do
    question_type = QuestionType.new
    assert_not question_type.save
  end
  
  test "type can't be saved when duplicated" do
    question_type = QuestionType.new(content: "selection")
    assert_not question_type.save
  end

end
