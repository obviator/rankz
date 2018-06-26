FactoryBot.define do
  factory :user, aliases: [:owner] do
    username 'Joe'
    email 'joe@gmail.com'
    password 'blahblah'
    confirmed_at Time.now
    factory :admin do
      after(:build) { |user| user.add_role(:admin) }
    end
    # factory :owner do
    #   transient do
    #     tournament nil
    #   end
    #   after(:build) do |user, evaluator|
    #     user.add_role(:owner, evaluator.tournament)
    #   end
    # end
  end
end