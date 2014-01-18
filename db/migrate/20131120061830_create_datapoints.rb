class CreateDatapoints < ActiveRecord::Migration
  def change
    create_table :datapoints do |t|
      t.integer :experiment_id
      t.integer :user_id
      t.integer :value

      t.timestamps
    end
  end
end
