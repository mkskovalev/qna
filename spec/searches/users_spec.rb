require 'rails_helper'

RSpec.describe User do
  describe User, search: true do

    it "searches body" do
      User.create!(email: "test@test.com", password: '123456', password_confirmation: '123456')
      User.search_index.refresh
      assert_equal ["test@test.com"], User.search("test@test.com").map(&:email)
    end
  end
end
