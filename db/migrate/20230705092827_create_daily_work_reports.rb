class CreateDailyWorkReports < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_work_reports do |t|
      t.date :current_date
      t.string :project_selection
      t.integer :hours
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
