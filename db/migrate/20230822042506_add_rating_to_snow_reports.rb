class AddRatingToSnowReports < ActiveRecord::Migration[7.0]
  def change
    add_column :snow_reports, :rating, :integer
  end
end
