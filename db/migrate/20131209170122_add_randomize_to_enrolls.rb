class AddRandomizeToEnrolls < ActiveRecord::Migration
  def change
    add_column :enrolls, :randomize, :integer
  end
end
