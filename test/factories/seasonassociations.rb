FactoryGirl.define do
  factory :seasonassociation do
    association :player
    association :season
  end

end
