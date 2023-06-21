class AddNewColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :dob, :date
    add_column :users, :address, :string
    add_column :users, :contact, :string
  end
end

