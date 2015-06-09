class RefillPlayersAndSeasons < ActiveRecord::Migration
  def change
        season_labels = ActiveSupport::JSON.decode(File.read("jsons/better_season_labels.json"))      
        season_labels = season_labels.map { |x| x.to_sym }
        season_types = ActiveSupport::JSON.decode(File.read("jsons/better_season_types.json"))
        season_types = season_types.map { |x| x.to_sym }
        season_labels.zip(season_types).each do |label, type|
                add_column :seasons, label, type
        end
        player_labels = ActiveSupport::JSON.decode(File.read("jsons/better_player_labels.json"))
        player_labels = player_labels.map { |x| x.to_sym }
        player_types = ActiveSupport::JSON.decode(File.read("jsons/better_player_types.json"))
        player_types = player_types.map { |x| x.to_sym }
        player_labels.zip(player_types).each do |label, type|
                add_column :players, label, type
        end


  end
end
