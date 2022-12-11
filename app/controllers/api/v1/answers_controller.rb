class Api::V1::AnswersController < Api::V1::BaseController
  before_action -> { authorize! :read, Answer }

  def index
    @question = Question.find(params[:question_id])
    render json: @question.answers, each_serializer: AnswersSerializer
  end

  def show
    @answer = Answer.find(params[:id])
    render json: @answer, serializer: AnswerSerializer
  end
end
