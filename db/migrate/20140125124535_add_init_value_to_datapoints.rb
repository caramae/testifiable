class AddInitValueToDatapoints < ActiveRecord::Migration
  def change
    add_column :datapoints, :init_value, :decimal
  end
end
