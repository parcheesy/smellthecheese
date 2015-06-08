class RemoveAppObjectIdFromPlayers < ActiveRecord::Migration
  def change
        remove_column :players, :app_object_id
  end
end
