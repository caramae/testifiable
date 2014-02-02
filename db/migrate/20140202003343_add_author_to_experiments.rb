class AddAuthorToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :author, :integer
  end
end
