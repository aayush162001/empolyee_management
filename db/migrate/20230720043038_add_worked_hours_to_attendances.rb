class AddWorkedHoursToAttendances < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :work_hours, :float
  end
end
