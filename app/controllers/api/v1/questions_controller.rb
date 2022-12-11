class Api::V1::QuestionsController < Api::V1::BaseController

  def index
    authorize! :read, Question
    @questions = Question.all
    render json: @questions, each_serializer: QuestionsSerializer
  end

  def show
    authorize! :read, Question
    @question = Question.find(params[:id])
    render json: @question, serializer: QuestionSerializer
  end
end
