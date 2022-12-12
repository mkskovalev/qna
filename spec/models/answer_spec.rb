require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:answer) { create(:answer, body: 'new body') }

  describe 'validations' do
    it { should validate_presence_of :body }
    it { should validate_uniqueness_of(:body).scoped_to(:question_id).case_insensitive }
  end

  describe 'associations' do
    it { should belong_to(:question) }
    it { should belong_to(:author).class_name('User') }

    it_behaves_like 'Votable'
    it_behaves_like 'Commentable'
    it_behaves_like 'Linkable'

    it 'have many attached files' do
      expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end

  it_behaves_like 'Broadcastable' do
    let!(:question) { create(:question) }
    let(:channel) { "question_#{question.id}" }
  end
end
