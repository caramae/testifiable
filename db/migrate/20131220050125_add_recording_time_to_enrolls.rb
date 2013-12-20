class AddRecordingTimeToEnrolls < ActiveRecord::Migration
  def change
    add_column :enrolls, :recording_time, :datetime
  end
end
