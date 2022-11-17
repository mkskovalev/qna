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
    resource = instance_variable_get("@#{controller_name.singularize}")

    if @vote.present?
      @vote.rating == rating ? @vote.destroy : @vote.update(rating: rating)
    else
      current_user.votes.create(votable_type: "#{resource.class}", votable_id: resource.id, rating: rating)
    end

    respond_to do |format|
      format.json { render json: resource.rating }
    end
  end
end
