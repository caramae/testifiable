class AddTimeframeUnitsToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :timeframe_units, :string
    change_column :experiments, :timeframe, :integer
  end
end
