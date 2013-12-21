class RenameApprovedInExperiments < ActiveRecord::Migration
  def change
  	rename_column :experiments, :approved, :is_public
  end
end
