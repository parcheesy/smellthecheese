class FillSectors < ActiveRecord::Migration
  def change
        sector_labels = ActiveSupport::JSON.decode(File.read("jsons/opengov_labels.json"))
        sector_labels = sector_labels.map { |x| x.to_sym }
        sector_types = ActiveSupport::JSON.decode(File.read("jsons/opengov_types.json"))
        sector_types = sector_types.map { |x| x.to_sym }
        sector_labels.zip(sector_types).each do |label, type|
                add_column :sectors, label, type
        end
  end
end
