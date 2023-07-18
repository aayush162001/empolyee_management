class AddCheckInToattendance < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :check_in, :datetime
    add_column :attendances, :check_out, :datetime
    rename_column :attendances, :date, :attendance_date
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
