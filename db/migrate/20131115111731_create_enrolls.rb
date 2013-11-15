class CreateEnrolls < ActiveRecord::Migration
  def change
    create_table :enrolls do |t|
      t.integer :user_id
      t.integer :experiment_id

      t.timestamps
    end
  end
end
