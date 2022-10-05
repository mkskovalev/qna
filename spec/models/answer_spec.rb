require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:answer) { create(:answer, body: 'new body') }

  describe 'validations' do
    it { should validate_presence_of :body }
    it { should validate_uniqueness_of(:body).scoped_to(:question_id).case_insensitive }
  end

  describe 'associations' do
    it { should belong_to(:question) }
    it { expect(answer.question).to_not be(nil) }

    it { should belong_to(:author).class_name('User') }
    it { expect(answer.user_id).to_not be(nil) }
  end
end
