class AddConnectionIdToSectors < ActiveRecord::Migration
  def change
    add_column :sectors, :connection_id, :integer
  end
end
