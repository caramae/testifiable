class AddTimeframeUnitsToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :timeframe_units, :string
    remove_column :experiments, :timeframe, :string
    add_column :experiments, :timeframe, :integer
  end
end
