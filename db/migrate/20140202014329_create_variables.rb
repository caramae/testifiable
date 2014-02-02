class CreateVariables < ActiveRecord::Migration
  def change
    rename_table :outcomes, :variables
  end
end
