require 'rails_helper'

RSpec.describe Answer, type: :model do

  describe 'validations' do
    answer = FactoryBot.create(:answer, body: 'why?')

    it { should validate_presence_of :body }
    it { should validate_uniqueness_of(:body).scoped_to(:question_id).case_insensitive }
  end

  describe 'associations' do
    answer = FactoryBot.build(:answer)

    it { should belong_to(:question) }
    it { expect(answer.question).to_not be(nil) }
  end
end
