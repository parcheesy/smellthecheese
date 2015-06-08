class RemoveAppObjectIdFromApps < ActiveRecord::Migration
  def change
        remove_column :apps, :app_object_id
  end
end
