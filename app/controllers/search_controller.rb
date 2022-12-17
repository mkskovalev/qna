class SearchController < ApplicationController

  def index
    authorize! :read, :all
    @query = params[:q]
    @model = params[:model]

    if @model == 'Everywhere'
      @response = {}
      @response['questions'] = Question.search(@query)
      @response['answers'] = Answer.search(@query)
      @response['users'] = User.search(@query)
      @response['comments'] = Comment.search(@query)
    else
      @response = @model.singularize.constantize.search(@query)
    end
  end
end
