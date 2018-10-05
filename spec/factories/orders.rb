FactoryBot.define do
  factory :order do
    sequence(:email) { |n| "example#{n}@gmail.com" }
    first_name { 'John' }
    last_name { 'Snow' }
    amount { rand(1..10**3) }
  end
end
