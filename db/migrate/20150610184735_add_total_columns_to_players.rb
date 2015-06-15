class AddTotalColumnsToPlayers < ActiveRecord::Migration
  def change
        add_column :players, :fga, :integer
        add_column :players, :fgm, :integer
        add_column :players, :dist_0to3feet_fga, :decimal
        add_column :players, :dist_0to3feet_fgm, :decimal
        add_column :players, :dist_3to10feet_fga, :decimal
        add_column :players, :dist_3to10feet_fgm, :decimal
        add_column :players, :dist_10to16feet_fgm, :decimal
        add_column :players, :dist_10to16feet_fga, :decimal
        add_column :players, :dist_16to3pt_fgm, :decimal
        add_column :players, :dist_16to3pt_fga, :decimal
        add_column :players, :threept_fgm, :decimal
        add_column :players, :threept_fga, :decimal
        add_column :players, :twopt_fgm, :decimal
        add_column :players, :twopt_fga, :decimal
        add_column :players, :corner_fgm, :decimal
        add_column :players, :corner_fga, :decimal
        add_column :players, :non_corner_fgm, :decimal
        add_column :players, :non_corner_fga, :decimal
        
  end
end
