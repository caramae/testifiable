class AddMustEmailToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :must_email, :boolean
  end
end
