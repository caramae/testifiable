class AddNextTimeToEnrolls < ActiveRecord::Migration
  def change
    add_column :enrolls, :next_time, :DateTime
    rename_column :enrolls, :randomize, :status
  end
end
