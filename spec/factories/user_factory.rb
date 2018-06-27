FactoryBot.define do
  factory :user, aliases: [:owner] do
    username { Faker::Internet.unique.user_name(3..20) }
    email { Faker::Internet.unique.safe_email }
    password { Faker::Internet.password(8, 20) }
    confirmed_at Time.now

    factory :admin do
      after(:build) { |user| user.add_role(:admin) }
    end
  end
end