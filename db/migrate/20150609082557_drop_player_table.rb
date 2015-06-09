class DropPlayerTable < ActiveRecord::Migration
  def change
        drop_table :players
        drop_table :seasons
  end
end
