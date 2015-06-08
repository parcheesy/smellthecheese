class AddPositionToApps < ActiveRecord::Migration
  def change
    add_column :apps, :position, :string
    add_column :apps, :string, :string
  end
end
