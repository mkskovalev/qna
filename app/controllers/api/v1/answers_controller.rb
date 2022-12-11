class Api::V1::AnswersController < Api::V1::BaseController
  before_action -> { authorize! :read, Answer }
  before_action :find_question, only: [:index]

  def index
    render json: @question.answers, each_serializer: AnswersSerializer
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end
end
