class CreateHolidays < ActiveRecord::Migration[7.0]
  def change
    create_table :holidays do |t|
      t.string :title
      t.date :holiday_date
      t.timestamps
    end
  end
end
