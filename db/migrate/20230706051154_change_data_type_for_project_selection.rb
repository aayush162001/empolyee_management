class ChangeDataTypeForProjectSelection < ActiveRecord::Migration[7.0]
  def change
    change_column(:daily_work_reports, :project_selection, :integer)
  end
end
