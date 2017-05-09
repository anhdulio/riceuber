class QuestionChoicesController < ApplicationController
  before_action :set_question_choice, only: [:show, :update, :destroy]

  # GET /question_choices
  def index
    @question_choices = QuestionChoice.all
    render json: @question_choices
  end

  # GET /question_choices/1
  def show
    render json: @question_choice
  end

  # POST /question_choices
  def create
    @question_choice = QuestionChoice.new(question_choice_params)
    if @question_choice.save
      render json: @question_choice, status: :created, location: @question_choice
    else
      render json: @question_choice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /question_choices/1
  def update
    if @question_choice.update(question_choice_params)
      render json: @question_choice
    else
      render json: @question_choice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /question_choices/1
  def destroy
    @question_choice.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_choice
      @question_choice = QuestionChoice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_choice_params
      params.require(:question_choice).permit(:content, :question_id)
    end
end
