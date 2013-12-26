class AddEndtimeToEnrolls < ActiveRecord::Migration
  def change
    add_column :enrolls, :end_time, :DateTime
  end
end
