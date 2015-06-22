class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
        t.timestamps
    end
  end
end
