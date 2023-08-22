class FixUserInCheckIns < ActiveRecord::Migration[7.0]
  def change
    remove_reference :check_ins, :users
    add_reference :check_ins, :user, foreign_key: true
  end
end
