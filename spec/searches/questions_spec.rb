require 'rails_helper'

RSpec.describe Question do
  describe Question, search: true do
    let!(:user) { create(:user) }

    it "searches title" do
      Question.create!(title: "Apple", body: "some", author: user)
      Question.search_index.refresh
      assert_equal ["Apple"], Question.search("apple").map(&:title)
    end

    it "searches body" do
      Question.create!(title: "Apple", body: "some", author: user)
      Question.search_index.refresh
      assert_equal ["some"], Question.search("some").map(&:body)
    end
  end
end
