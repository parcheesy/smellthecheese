module AppsHelper
        def fg_type_taken_hash(players) 
                        {:two_pt_fg => players.sum(:twopt_fga), :three_pt_fg => players.sum(:threept_fga)}
        end


        def fg_type_perc_made_hash(players)
                        {:two_pt_fg => players.sum_percents(:twopt_fgm, :twopt_fga), :three_pt_fg  => players.sum_percents(:threept_fgm, :threept_fga)}
        end

        def dist_taken_hash(players)
                        {:zero_to_three => players.sum_percents(:dist_0to3feet_fga, :fga), :three_to_ten => players.sum_percents(:dist_3to10feet_fga, :fga), :ten_to_sixteen => players.sum_percents(:dist_10to16feet_fga, :fga), :sixteen_to_three_pt => players.sum_percents(:dist_16to3pt_fga, :fga), :three_pt_plus  => players.sum_percents(:threept_fga, :fga)}
        end

        def dist_perc_made_hash(players)
                        {:zero_to_three => players.sum_percents(:dist_0to3feet_fgm, :dist_0to3feet_fga), :three_to_ten => players.sum_percents(:dist_3to10feet_fgm, :dist_3to10feet_fga), :ten_to_sixteen => players.sum_percents(:dist_10to16feet_fgm, :dist_10to16feet_fga), :sixteen_to_three_pt => players.sum_percents(:dist_16to3pt_fgm, :dist_16to3pt_fga,), :three_pt_plus  => players.sum_percents(:threept_fgm, :threept_fga)}

        end


end
