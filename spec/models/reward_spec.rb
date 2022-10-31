require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
  end

  describe 'associations' do
    it { should belong_to(:question) }

    it 'have one attached image' do
      expect(Reward.new.image).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end
end
