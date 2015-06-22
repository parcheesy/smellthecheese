class AddKeywordsToSectors < ActiveRecord::Migration
  def change
    add_column :sectors, :keywords, :string
  end
end
