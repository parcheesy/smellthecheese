class RenameCodeInApps < ActiveRecord::Migration
  def change
        rename_column :apps, :code, :html
  end
end
