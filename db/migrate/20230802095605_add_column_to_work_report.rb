class AddColumnToWorkReport < ActiveRecord::Migration[7.0]
  def change
    add_column :daily_work_reports, :created_by, :string
  end
end
