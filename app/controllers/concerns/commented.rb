module Commented
  extend ActiveSupport::Concern

  included do
    before_action :find_source, only: [:comment]
  end

  def comment
    comment = @source.comments.new(comment_params)
    comment.user_id = current_user.id

    comment.save

    respond_to do |format|
      format.html { render partial: 'shared/comment', locals: { comment: comment } }
    end
  end

  private

  def find_source
    model = controller_name.classify.constantize
    @source = model.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
