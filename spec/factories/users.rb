FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}@test.com" }
    password '123123123'
  end
end
