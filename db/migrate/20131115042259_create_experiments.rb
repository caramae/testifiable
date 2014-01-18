class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :action
      t.string :control
      t.string :outcome
      t.string :unit

      t.timestamps
    end
  end
end
