FactoryBot.define do
  factory :user do
    username 'Joe'
    email 'joe@gmail.com'
    password 'blahblah'
    confirmed_at Time.now
    factory :admin do
      after(:build) { |user| user.add_role(:admin) }
    end
  end
end