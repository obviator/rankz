# frozen_string_literal: true

FactoryBot.define do
  factory :tournament do
    start_date Date.today + 7
    end_date Date.today + 8

    name 'tournament name 1'
    slug 'slug'
    active 1
    wincalc '9+min(3,tf)+min(3,cf)'
    drawcalc '3+min(3,tf)+min(3,cf)'
    losecalc 'limit(15+limit(cn,-3,3)-min(is(tf=0)*ta,3)+tn*3,0,32)'
    concedecalc '-1'
    # factory :owner do
    #   transient do
    #     tournament nil
    #   end
    #   after(:build) do |user, evaluator|
    #     user.add_role(:owner, evaluator.tournament)
    #   end
    # end
    transient do
      owner nil
    end
    after(:create) do |tournament, evaluator|
      evaluator.owner.add_role(:owner, tournament)
    end
  end
end
