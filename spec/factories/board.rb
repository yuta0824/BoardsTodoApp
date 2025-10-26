FactoryBot.define do
  factory :board do
    name { Faker::Lorem.characters(number: 10) }
    description { Faker::Lorem.characters(number: 30) }
    association :user
  end
end
