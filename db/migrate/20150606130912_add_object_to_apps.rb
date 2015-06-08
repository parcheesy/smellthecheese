class AddObjectToApps < ActiveRecord::Migration
  def change
    add_column :apps, :object, :string
  end
end
