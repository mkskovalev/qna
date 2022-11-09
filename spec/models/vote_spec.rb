require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'validations' do
    it { should validate_presence_of :rating }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:votable) }
  end
end
