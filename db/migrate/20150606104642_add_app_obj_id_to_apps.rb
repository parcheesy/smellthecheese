class AddAppObjIdToApps < ActiveRecord::Migration
  def change
        add_column :apps, :app_object_id, :integer
        add_index :apps, :app_object_id
  end
  
end
