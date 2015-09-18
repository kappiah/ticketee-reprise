FactoryGirl.define do
  factory :user do
    email "test@example.com"
    password "password"

    trait :admin do
      admin true
    end
  end
end
