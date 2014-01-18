class AddPasswordconfirmToUsers < ActiveRecord::Migration
  def change
    add_column :users, :passwordconfirm, :string
  end
end
