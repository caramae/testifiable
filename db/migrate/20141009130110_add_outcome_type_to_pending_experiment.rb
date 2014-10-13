class AddOutcomeTypeToPendingExperiment < ActiveRecord::Migration
  def change
    add_column :pending_experiments, :outcome_type, :string
  end
end
