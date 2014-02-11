class AddPendStatusToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :pend_status, :integer
  end
end
