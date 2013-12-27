class AddExperimentIdToOutcomes < ActiveRecord::Migration
  def change
    add_column :outcomes, :experiment_id, :integer
  end
end
