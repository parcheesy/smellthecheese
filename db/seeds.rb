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
