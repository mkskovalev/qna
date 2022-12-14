FactoryBot.define do
  factory :answer do
    body
    question
    association :author, factory: :user

    trait :with_file do
      files { [fixture_file_upload(Rails.root.join('spec', 'rails_helper.rb'), 'rails_helper/rb')] }
    end

    trait :invalid do
      body { nil }
    end

    trait :reindex do
      after(:create) do |answer, _evaluator|
        answer.reindex(refresh: true)
      end
    end
  end
end
