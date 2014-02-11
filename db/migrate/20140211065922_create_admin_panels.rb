class CreateAdminPanels < ActiveRecord::Migration
  def change
    create_table :admin_panels do |t|

      t.timestamps
    end
  end
end
