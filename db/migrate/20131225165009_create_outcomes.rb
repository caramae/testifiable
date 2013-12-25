class CreateOutcomes < ActiveRecord::Migration
  def change
    create_table :outcomes do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
