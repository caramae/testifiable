class AddCommentToDatapoints < ActiveRecord::Migration
  def change
    add_column :datapoints, :comment, :string
  end
end
