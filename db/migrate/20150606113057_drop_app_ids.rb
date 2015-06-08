class DropAppIds < ActiveRecord::Migration
  def change
        drop_table :app_objects
  end
end
