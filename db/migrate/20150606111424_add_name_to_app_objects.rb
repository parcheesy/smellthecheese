class AddNameToAppObjects < ActiveRecord::Migration
  def change
    add_column :app_objects, :test, :string
  end
end
