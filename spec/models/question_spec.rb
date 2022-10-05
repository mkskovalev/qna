require 'rails_helper'

RSpec.describe Question, type: :model do

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_presence_of :author }
  end

  describe 'associations' do
    let(:question) { create(:question) }
    let(:answers) { create_list(:answer, 3, question: question) }

    it { should have_many(:answers) }
    it { expect(question).to have_many(:answers).dependent(:destroy) }

    it { should belong_to(:author).class_name('User') }
  end
end
