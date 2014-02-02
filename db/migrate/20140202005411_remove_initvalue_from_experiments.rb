class RemoveInitvalueFromExperiments < ActiveRecord::Migration
  def change
    remove_column :experiments, :initvalue, :integer
    add_column :outcomes, :has_init_value, :boolean
  end
end
