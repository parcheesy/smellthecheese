class RemoveCssFromApps < ActiveRecord::Migration
  def change
        remove_column :apps, :css
  end
end
