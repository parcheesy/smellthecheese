class CreateSeasonAssociations < ActiveRecord::Migration
  def change
    create_table :seasonassociations do |t|
      t.integer :player_id
      t.integer :season_id
    end
    add_index :seasonassociations, :player_id
    add_index :seasonassociations, :season_id
  end
end
