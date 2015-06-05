class AddNameAndCodeToApps < ActiveRecord::Migration
  def change
    add_column :apps, :name, :string
    add_column :apps, :code, :text
  end
end
