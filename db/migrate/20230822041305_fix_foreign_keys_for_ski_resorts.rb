class FixForeignKeysForSkiResorts < ActiveRecord::Migration[7.0]
  def change
    remove_reference :check_ins, :ski_resorts
    add_reference :check_ins, :ski_resort, foreign_key: true
    remove_reference :reviews, :check_ins
    add_reference :reviews, :check_in, foreign_key: true
    remove_reference :snow_reports, :check_ins
    add_reference :snow_reports, :check_in, foreign_key: true
  end
end
