require 'rails_helper'

RSpec.describe Question, type: :model do

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
  end

  describe 'associations' do
    question = FactoryBot.build(:question)
    answer = FactoryBot.build(:answer)
    question.answers << answer

    it { should have_many(:answers) }
    it { expect(question).to have_many(:answers).dependent(:destroy) }
  end
end
