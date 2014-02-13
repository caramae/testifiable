class CreatePendingExperiments < ActiveRecord::Migration
  def change
    create_table :pending_experiments do |t|
      t.string :action
      t.string :control
      t.integer :author
      t.string :prereqs
      t.boolean :is_public
      t.string :timeinterval
      t.string :timeframe_units
      t.integer :timeframe
      t.string :category
      t.boolean :must_email

      t.timestamps
    end
  end
end