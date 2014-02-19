class AddSpanningActionToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :spanning_action, :boolean, default: true
  end
end
