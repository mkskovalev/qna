require 'rails_helper'

RSpec.describe AnswersChannel, type: :channel do
  it "successfully subscribes" do
    subscribe
    expect(subscription).to be_confirmed
  end
end
