class CreateCheckInOuts < ActiveRecord::Migration[7.0]
  def change
    create_table :check_in_outs do |t|
      t.date :attendance_date
      t.datetime :check_in
      t.datetime :check_out
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
