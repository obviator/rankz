FactoryBot.define do
  factory :race do
    name { Faker::StarTrek.unique.specie }
    tournament
    active 1
  end
end