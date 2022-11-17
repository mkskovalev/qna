module Voted
  extend ActiveSupport::Concern

  def like
    vote_calculation(1)
  end

  def unlike
    vote_calculation(-1)
  end

  private

  def vote_calculation(rating)
    if @vote.present?
      @vote.rating == rating ? @vote.destroy : @vote.update(rating: rating)
    else
      current_user.votes.create(votable_type: "#{@question.class}", votable_id: @question.id, rating: rating)
    end

    respond_to do |format|
      format.json { render json: @question.rating }
    end
  end
end
