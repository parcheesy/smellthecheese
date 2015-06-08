class AddCssidAndCitationToApps < ActiveRecord::Migration
  def change
    add_column :apps, :cssid, :string
    add_column :apps, :citation, :string
  end
end
