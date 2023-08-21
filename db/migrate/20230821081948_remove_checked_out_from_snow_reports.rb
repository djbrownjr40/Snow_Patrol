class RemoveCheckedOutFromSnowReports < ActiveRecord::Migration[7.0]
  def change
    remove_column :snow_reports, :checked_out_at, :datetime
  end
end
