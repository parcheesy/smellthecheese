class AddCssAndJsToApps < ActiveRecord::Migration
  def change
    add_column :apps, :css, :text
    add_column :apps, :js, :text
  end
end
