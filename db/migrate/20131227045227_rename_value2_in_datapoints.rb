class RenameValue2InDatapoints < ActiveRecord::Migration
  def change
    rename_column :datapoints, :value2, :iv_value
  end
end
