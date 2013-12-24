class RenameFrequencyInExperiments < ActiveRecord::Migration
  def change
  	rename_column :experiments, :frequency, :timeinterval
  end
end
