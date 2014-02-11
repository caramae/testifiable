class AddExperimentIdToPendingExperiments < ActiveRecord::Migration
  def change
    add_column :pending_experiments, :experiment_id, :integer
  end
end
