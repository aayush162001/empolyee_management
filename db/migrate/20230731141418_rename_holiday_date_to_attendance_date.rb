class RenameHolidayDateToAttendanceDate < ActiveRecord::Migration[7.0]
  def change
    rename_column :holidays, :holiday_date, :attendance_date
  end
end
