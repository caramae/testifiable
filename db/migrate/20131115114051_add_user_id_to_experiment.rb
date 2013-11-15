class AddUserIdToExperiment < ActiveRecord::Migration
  def change
    add_column :experiments, :author, :integer
  end
end
