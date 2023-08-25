class AddColumnActiveToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :update_by, :integer
  end
end
