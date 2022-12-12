class Api::V1::QuestionsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  before_action -> { authorize! :create, Question }

  def index
    @questions = Question.all
    render json: @questions, each_serializer: QuestionsSerializer
  end

  def show
    @question = Question.find(params[:id])
    render json: @question, serializer: QuestionSerializer
  end

  def create
    question = current_resource_owner.questions.new(question_params)

    if question.save
      render json: question, status: :created
    else
      render json: { errors: question.errors }, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
