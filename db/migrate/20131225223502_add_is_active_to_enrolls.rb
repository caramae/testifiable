class AddIsActiveToEnrolls < ActiveRecord::Migration
  def change
    add_column :enrolls, :is_active, :boolean
  end
end
