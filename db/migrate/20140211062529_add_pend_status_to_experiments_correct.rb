class AddPendStatusToExperimentsCorrect < ActiveRecord::Migration
  def change
    add_column :experiments, :pend_status, :integer, :default => 0
  end
end
