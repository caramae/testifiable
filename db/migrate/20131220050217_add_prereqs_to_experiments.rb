class AddPrereqsToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :prereqs, :string
    add_column :experiments, :approved, :boolean
  end
end
