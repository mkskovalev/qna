FactoryBot.define do
  factory :answer do
    body
    question

    trait :invalid do
      body { nil }
    end
  end
end
