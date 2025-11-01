FactoryBot.define do
  factory :task do
    name { Faker::Lorem.characters(number: 10) }
    description { Faker::Lorem.characters(number: 30) }
    association :user
    association :board
  end
end
