Player.destroy_all
Season.destroy_all

players = ActiveSupport::JSON.decode(File.read("jsons/playoff_players.json"))
seasons = ActiveSupport::JSON.decode(File.read("jsons/player_playoff_seasons.json"))

Player.create!(players)

p "Created #{Player.count} players"

Season.create!(seasons)

p "Created #{Season.count} seasons"

all_seasons = Season.all
all_seasons.each do |season|
        season.update(player: Player.where(name: season.name).first)
end

p "Added #{Season.where.not(player_id: nil).count} seasons to players"

Article.create(title: "NBA Player Performance: Regular Season vs Playoffs",
                date: "June 3, 2015",
                body: "Often in analysis of playoff series, including the current championship matchup between the Cleveland Cavaliers and Golden State Warriors, regular season statistics and performance end up being the predominant factor in predictions. Granted, this makes sense because that is the best source of information about the teams as currently constructed.  However, some important factors that are often left out of the analysis are how performance changes in the playoffs. Whether certain players, styles, or teams tend to perform better or worse once the playoffs roll around. Additionally, people still rely heavily on regular season performance over earlier rounds of the playoffs.")
                
p "Loaded #{Article.count} articles"
