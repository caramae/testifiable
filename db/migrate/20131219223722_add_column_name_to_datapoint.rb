class AddColumnNameToDatapoint < ActiveRecord::Migration
  def change
    add_column :datapoints, :compliance, :boolean
    add_column :datapoints, :value2, :decimal
    change_column :datapoints, :value, :decimal
  end
end
