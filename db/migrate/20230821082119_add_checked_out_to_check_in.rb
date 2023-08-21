class AddCheckedOutToCheckIn < ActiveRecord::Migration[7.0]
  def change
    add_column :check_ins, :checked_out_at, :datetime
  end
end
