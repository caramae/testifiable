class AddDurationInDaysToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :duration_in_days, :integer
  end
end
