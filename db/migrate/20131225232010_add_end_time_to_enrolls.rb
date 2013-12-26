class AddEndTimeToEnrolls < ActiveRecord::Migration
  def change
    add_column :enrolls, :end_time, :datetime
  end
end
