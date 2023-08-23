class AddFeaturesToSkiResorts < ActiveRecord::Migration[7.0]
  def change
    add_column :ski_resorts, :features, :text
  end
end
