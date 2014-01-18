class RemovePasswordconfirmFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :passwordconfirm, :string
  end
end
