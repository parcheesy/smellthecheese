class AddAppObjectIdToPlayers < ActiveRecord::Migration
  def change
        add_column :players, :app_object_id, :integer
        add_index :players, :app_object_id
  end
end
