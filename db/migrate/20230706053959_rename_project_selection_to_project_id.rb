class RenameProjectSelectionToProjectId < ActiveRecord::Migration[7.0]
  def change
    rename_column :daily_work_reports, :project_selection, :project_id
  end
end
