class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.date :date
      t.text :body
      t.string :imagePath

      t.timestamps
    end
  end
end
