class AddAllowRepeatsToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :allow_repeats, :boolean, :default => true
  end
end
