class CreateSnowReports < ActiveRecord::Migration[7.0]
  def change
    create_table :snow_reports do |t|
      t.datetime :checked_out_at
      t.timestamps
    end
  end
end
