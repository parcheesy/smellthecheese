class AddConnectionIdToApps < ActiveRecord::Migration
  def change
    add_column :apps, :connection_id, :integer
    add_index :apps, :connection_id
  end
       
end
