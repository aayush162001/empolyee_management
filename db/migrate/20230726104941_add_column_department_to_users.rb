class AddColumnDepartmentToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :department, foreign_key: true
    add_reference :users, :designation, foreign_key: true
  end
end
