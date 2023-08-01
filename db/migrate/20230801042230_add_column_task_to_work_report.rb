class AddColumnTaskToWorkReport < ActiveRecord::Migration[7.0]
  def change
    add_column :daily_work_reports, :task, :string
  end
end
