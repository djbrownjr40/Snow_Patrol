class AddReferenceToCheckIn < ActiveRecord::Migration[7.0]
  def change
    add_reference :check_ins, :users, foreign_key: true
    add_reference :check_ins, :ski_resorts, foreign_key: true
  end
end
