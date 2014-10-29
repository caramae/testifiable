class AddIncrementToExperiment < ActiveRecord::Migration
  def change
    add_column :experiments, :exp_increment, :string
    add_column :experiments, :exp_increment_time, :integer
  end
end
