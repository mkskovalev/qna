FactoryBot.define do
  factory :comment do
    body { "MyString" }
    association :commentable
  end

  trait :reindex do
    after(:create) do |comment, _evaluator|
      comment.reindex(refresh: true)
    end
  end
end
