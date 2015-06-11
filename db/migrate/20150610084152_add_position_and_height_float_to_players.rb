class AddPositionAndHeightFloatToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :position, :string
    add_column :players, :height_float, :float
  end
end
