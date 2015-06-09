class RemakePlayerAndSeasonTables < ActiveRecord::Migration
  def change
        create_table :players do |t|
                t.timestamps
        end
        create_table :seasons do |t|
                t.timestamps
        end
  end
end
