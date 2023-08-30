class AddCoursesToSkiResorts < ActiveRecord::Migration[7.0]
  def change
    add_column :ski_resorts, :courses, :text
  end
end
