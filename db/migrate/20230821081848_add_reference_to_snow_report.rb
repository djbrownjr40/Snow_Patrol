class AddReferenceToSnowReport < ActiveRecord::Migration[7.0]
  def change
    add_reference :snow_reports, :check_ins, foreign_key: true
  end
end
