class RemoveStringFromApps < ActiveRecord::Migration
  def change
        remove_column :apps, :string
  end
end
