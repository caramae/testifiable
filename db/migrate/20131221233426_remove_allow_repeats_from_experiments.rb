class RemoveAllowRepeatsFromExperiments < ActiveRecord::Migration
  def change
    remove_column :experiments, :allow_repeats, :boolean
    remove_column :experiments, :duration_in_days, :integer
    add_column :experiments, :frequency, :string
  end
end
