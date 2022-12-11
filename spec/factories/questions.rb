FactoryBot.define do
  sequence :title do |n|
    "MyString#{n}"
  end

  sequence :body do |n|
    "MyText#{n}"
  end

  factory :question do
    title
    body
    association :author, factory: :user

    trait :with_file do
      files { [fixture_file_upload(Rails.root.join('spec', 'rails_helper.rb'), 'rails_helper/rb')] }
    end

    trait :invalid do
      title { nil }
    end

    trait :with_comments do
      after(:build) do |question|
        question.comments = FactoryBot.build_list(:comment, 3, user_id: create(:user).id)
      end

      # body { 'some comment' }
      # user
      # association :commentable, factory: :comment
    end
  end
end
