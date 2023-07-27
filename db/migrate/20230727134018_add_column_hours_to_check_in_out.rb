class AddColumnHoursToCheckInOut < ActiveRecord::Migration[7.0]
  def change
    add_column :check_in_outs, :work_hours, :float
  end
end
