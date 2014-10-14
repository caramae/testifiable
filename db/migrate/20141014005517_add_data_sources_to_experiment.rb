class AddDataSourcesToExperiment < ActiveRecord::Migration
  def change
    add_column :experiments, :data_sources, :string
  end
end
