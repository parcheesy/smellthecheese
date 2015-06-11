module AppsHelper
        def fg_type_taken_hash(players, type="ruby") 
                if type=="js"
                        {'2pt FG' => 'players.sum(:twopt_fga)', '3pt FG' => 'players.sum(:threept_fga)'}
                else 
                        {'2pt FG' => players.sum(:twopt_fga), '3pt FG' => players.sum(:threept_fga)}
                end
        end


        def fg_type_perc_made_hash(players, type="ruby")
                if type=="js"
                        {'2pt FG' => 'players.sum_percents(:twopt_fgm, :twopt_fga)', '3pt FG' => 'players.sum_percents(:threept_fgm, :threept_fga)'}
                else
                        {'2pt FG' => players.sum_percents(:twopt_fgm, :twopt_fga), '3pt FG' => players.sum_percents(:threept_fgm, :threept_fga)}
                end
        end

        def dist_taken_hash(players, type="ruby")
                if type=="js"
                        {'0-3ft' => 'players.sum(:dist_0to3feet_fga)', '3-10ft' => 'players.sum(:dist_3to10feet_fga)', '10-16ft' => 'players.sum(:dist_10to16feet_fga)', '16ft-3PT' => 'players.sum(:dist_16to3pt_fga)', '3PT+' => 'players.sum(:threept_fga)'}
                else
                        {'0-3ft' => players.sum_percents(:dist_0to3feet_fga, :fga), '3-10ft' => players.sum_percents(:dist_3to10feet_fga, :fga), '10-16ft' => players.sum_percents(:dist_10to16feet_fga, :fga), '16ft-3PT' => players.sum_percents(:dist_16to3pt_fga, :fga), '3PT+' => players.sum_percents(:threept_fga, :fga)}
                end
        end

        def dist_perc_made_hash(players, type="ruby")
                if type=="js"
                        {'0-3ft' => 'players.sum_percents(:dist_0to3feet_fgm, :dist_0to3feet_fga)', '3-10ft' => 'players.sum_percents(:dist_3to10feet_fgm, :dist_3to10feet_fga)', '10-16ft' => 'players.sum_percents(:dist_10to16feet_fgm, :dist_10to16feet_fga)', '16ft-3PT' => 'players.sum_percents(:dist_16to3pt_fgm, :dist_16to3pt_fga)', '3PT+' => 'players.sum_percents(:threept_fgm, :threept_fga)'}
                else
                        {'0-3ft' => players.sum_percents(:dist_0to3feet_fgm, :dist_0to3feet_fga), '3-10ft' => players.sum_percents(:dist_3to10feet_fgm, :dist_3to10feet_fga), '10-16ft' => players.sum_percents(:dist_10to16feet_fgm, :dist_10to16feet_fga), '16ft-3PT' => players.sum_percents(:dist_16to3pt_fgm, :dist_16to3pt_fga), '3PT+' => players.sum_percents(:threept_fgm, :threept_fga)}
                end
        end

        def chart_options_hash(type="pie", height='200px')
                if type=="column"
                        {'library':{'backgroundColor':'#f8f8f8'}}
                else
                        {'library':{'backgroundColor':'#f8f8f8', 'tooltip':{'text':'percentage'}}}
                end
        end

end
