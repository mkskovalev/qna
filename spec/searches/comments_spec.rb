require 'rails_helper'

RSpec.describe Comment do
  describe Comment, search: true do
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }

    it "searches body" do
      Comment.create!(body: "Apple", user: user, commentable: question)
      Comment.search_index.refresh
      assert_equal ["Apple"], Comment.search("apple").map(&:body)
    end
  end
end
