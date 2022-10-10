class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:create, :edit]
  before_action :load_answer, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id

    @answer.save
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    if @answer.user_id == current_user.id
      @answer.destroy
      redirect_to question_path(@answer.question), notice: 'Answer successfully deleted.'
    else
      redirect_to question_path(@answer.question), notice: "You can't delete someone else's answer."
    end
  end

  private

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
