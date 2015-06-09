class ReAddConnectionIdToPlayers < ActiveRecord::Migration
  def change
        add_column :players, :connection_id, :integer
  end
end
