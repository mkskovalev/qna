class Api::V1::AnswersController < Api::V1::BaseController
  skip_authorization_check
  before_action :find_answer, only: [:show, :update, :destroy]


  def index
    @question = Question.find(params[:question_id])
    render json: @question.answers, each_serializer: AnswersSerializer
  end

  def show
    render json: @answer, serializer: AnswerSerializer
  end

  def create
    @question = Question.find(params[:question_id])
    answer = @question.answers.new(answer_params)
    answer.author = current_resource_owner

    if answer.save
      render json: answer, status: :created
    else
      render json: { errors: answer.errors }, status: :unprocessable_entity
    end
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
