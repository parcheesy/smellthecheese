class ChangeDateFormatInArticles < ActiveRecord::Migration
  def change
        change_column :articles, :date, :string
  end
end
