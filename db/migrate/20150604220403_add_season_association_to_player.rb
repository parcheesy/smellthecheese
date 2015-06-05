class AddSeasonAssociationToPlayer < ActiveRecord::Migration
  def change
        add_reference :seasons, :player, index: true
  end
end
