class AddConnectionIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :connection_id, :integer
    add_index :players, :connection_id
  end
end
