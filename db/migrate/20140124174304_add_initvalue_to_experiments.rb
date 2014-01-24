class AddInitvalueToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :initvalue, :integer
  end
end
