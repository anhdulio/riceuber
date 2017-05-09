class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.all

    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /questions
  # params: { question: {content: String}}, question_type: String, question_choices: ["Option 1", "Option 2"] }
  def create
    
    @question = Question.new(question_params)
    question_type_content = other_params['question_type']
    question_type = QuestionType.find_by content: question_type_content
    
    
    if question_type_content
      if question_type
        @question.question_type = QuestionType.find_by content: question_type_content
      else
        @question.question_type = QuestionType.new({content: question_type_content})
      end
    end

    if ["multiple","selection"].include? question_type_content
      if other_params['question_choices']
        other_params['question_choices'].each do |question_choice|
          question_choice = QuestionChoice.new({content: question_choice})
          @question.question_choices << question_choice  
        end
      end
    end
    
    if @question.save
      render json: @question, status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /questions/1
  # params: { question: {content: @question.content}, question_type: "open", question_choices: ["Option 1", "Option 2"] }
  def update
    
    if other_params['question_choices']
      @question.question_choices.destroy_all
      other_params['question_choices'].each do |qc|
        @qc = QuestionChoice.new({content: qc})
        @question.question_choices << @qc
      end
    end
  
    if other_params['question_type']
      @question_type = QuestionType.find_by content: other_params['question_type']
      if @question_type
        @question.question_type = @question_type
      else
        @question.question_type = QuestionType.new({content: other_params['question_type']}) 
      end
    end
    
    if @question.save & @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.question_choices.each do |question_choice|
      question_choice.destroy
  end
    @question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:content,:question_type_id)
    end

    def other_params
      params.permit(:question_type,question_choices: [])
    end
    
end
