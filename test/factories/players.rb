FactoryGirl.define do 
  factory :player do
    name "Michael Jordan"
    fga_pg 22.5
    fgm_pg 11.2
    games 82
    dist_0to3feet_percshots 0.16
    dist_3to10feet_percshots 0.10
    dist_10to16feet_percshots 0.22
    dist_16to3pt_percshots 0.25
    threept_percshots 0.42
    twopt_perc_shots 0.58
    corner_perc3pt 0.33
    threept_fga 3.4
    dist_0to3feet_perc 0.54
    dist_3to10feet_perc 0.49
    dist_10to16feet_perc 0.38
    dist_16to3pt_perc 0.43
    threept_perc 0.36
    twopt_perc 0.44
    corner_perc 0.40

    factory :player_with_seasons do
      
      transient do
        seasonassociations_count 3
      end

      after(:create) do |player, evaluator|
        create_list(:seasonassociation, evaluator.seasonassociations_count, player:player)

      end

    end

  end

end
