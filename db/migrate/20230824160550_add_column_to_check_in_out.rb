class AddColumnToCheckInOut < ActiveRecord::Migration[7.0]
  def change
    add_column :check_in_outs, :created_by, :integer
  end
end
