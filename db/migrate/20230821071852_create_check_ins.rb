class CreateCheckIns < ActiveRecord::Migration[7.0]
  def change
    create_table :check_ins do |t|
      t.integer :rating
      t.timestamps
    end
  end
end
