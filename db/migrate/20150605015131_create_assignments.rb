class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :app_id
      t.integer :article_id

      t.timestamps
    end
    add_index :assignments, :app_id
    add_index :assignments, :article_id
  end
end
