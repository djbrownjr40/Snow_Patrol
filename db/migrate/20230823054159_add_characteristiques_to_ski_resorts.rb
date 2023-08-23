class AddCharacteristiquesToSkiResorts < ActiveRecord::Migration[7.0]
  def change
    add_column :ski_resorts, :height, :float
    add_column :ski_resorts, :length, :float
    add_column :ski_resorts, :temp, :float
  end
end
