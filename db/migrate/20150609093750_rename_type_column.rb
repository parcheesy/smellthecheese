class RenameTypeColumn < ActiveRecord::Migration
  def change
        rename_column :players, :type, :stat
        rename_column :seasons, :type, :stat
  end
end
