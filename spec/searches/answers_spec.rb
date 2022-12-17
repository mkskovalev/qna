require 'rails_helper'

RSpec.describe Answer do
  describe Answer, search: true do
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }

    it "searches body" do
      Answer.create!(body: "Apple", author: user, question: question)
      Answer.search_index.refresh
      assert_equal ["Apple"], Answer.search("apple").map(&:body)
    end
  end
end
