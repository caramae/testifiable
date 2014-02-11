class RemovePendStatusFromExperiments < ActiveRecord::Migration
  def change
    remove_column :experiments, :pend_status
  end
end
