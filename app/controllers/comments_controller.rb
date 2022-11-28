class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = commentable.comments.new(comment_params)
    @comment.user_id = current_user.id

    @comment.save
    # publish_comment if @comment.save
  end

  private

  def commentable
    models = [Question, Answer]
    commentable_class = models.find { |klass| params["#{klass.name.underscore}_id"]}
    @commentable = commentable_class.find(params["#{commentable_class.name.underscore}_id"])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
