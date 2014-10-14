class AddDataSourcesToPendingExperiment < ActiveRecord::Migration
  def change
    add_column :pending_experiments, :data_sources, :string
  end
end
