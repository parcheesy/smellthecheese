class AddColumnsToSeasons < ActiveRecord::Migration
  def change
        labels = ActiveSupport::JSON.decode(File.read("jsons/labels.json"))      
        labels = labels.map { |x| x.to_sym }
        types = ActiveSupport::JSON.decode(File.read("jsons/types.json"))
        types = types.map { |x| x.to_sym }
        labels.zip(types).each do |label, type|
                add_column :seasons, label, type
        end
  end
end
