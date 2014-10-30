class AddFieldsToPendingExperiment < ActiveRecord::Migration
  def change
    add_column :pending_experiments, :exp_increment, :string
    add_column :pending_experiments, :exp_increment_time, :string
    add_column :pending_experiments, :day_of_week, :string
    add_column :pending_experiments, :end_time, :datetime
  end
end
