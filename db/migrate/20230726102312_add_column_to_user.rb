class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :created_by, :string
    add_column :users, :designation_id, :integer
    add_column :users, :department_id, :integer
    remove_column :users, :department
  end
end
