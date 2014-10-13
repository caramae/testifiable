class AddOutcomeTypeToExperiment < ActiveRecord::Migration
  def change
    add_column :experiments, :outcome_type, :string
  end
end
