require 'rails_helper'

RSpec.describe Question, type: :model do

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_presence_of :author }
  end

  describe 'associations' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:links).dependent(:destroy) }
    it { should belong_to(:author).class_name('User') }
    it { should have_one(:reward).dependent(:destroy) }
    it { should have_many(:votes).dependent(:destroy) }

    it { should accept_nested_attributes_for :links }
    it { should accept_nested_attributes_for :reward }

    it 'have many attached files' do
      expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end
end
