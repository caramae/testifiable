class RemoveFrequencyFromExperiments < ActiveRecord::Migration
  def change
    remove_column :experiments, :frequency, :string
    add_column :experiments, :timeframe, :integer
  end
end
