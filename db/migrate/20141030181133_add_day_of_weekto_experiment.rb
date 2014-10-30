class AddDayOfWeektoExperiment < ActiveRecord::Migration
  def change
    add_column :experiments, :day_of_week, :string
  end
end
