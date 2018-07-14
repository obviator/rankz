FactoryBot.define do
  factory :team do
    name { Faker::Team.unique.name }
    race
    tournament
    active 1
  end
end