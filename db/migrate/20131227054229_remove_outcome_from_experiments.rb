class RemoveOutcomeFromExperiments < ActiveRecord::Migration
  def change
    remove_column :experiments, :outcome, :string
    remove_column :experiments, :unit, :string
    add_column :outcomes, :unit, :string
  end
end
