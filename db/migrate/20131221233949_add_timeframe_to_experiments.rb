class AddTimeframeToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :timeframe, :string
  end
end
