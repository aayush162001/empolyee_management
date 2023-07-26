class RemoveColumnToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :department_id
    remove_column :users, :designation_id
  end
end
