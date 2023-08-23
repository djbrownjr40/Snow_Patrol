class AddSnowReportAverageToSkiResort < ActiveRecord::Migration[7.0]
  def change
    add_column :ski_resorts, :average_snow_report, :integer
  end
end
