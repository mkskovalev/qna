FactoryBot.define do
  sequence :email do |n|
    "test#{n}@mail.com"
  end

  factory :user do
    email
    password { '1234567' }
    password_confirmation { '1234567' }
  end

  trait :confirmed do
    confirmed_at { 'Wed, 07 Dec 2022 15:27:42 UTC +00:00' }
  end
end
