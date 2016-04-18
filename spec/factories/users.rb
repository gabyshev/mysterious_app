FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}@test.com" }
    password '123123123'

    trait :admin do
      role 'admin'
    end
  end
end
