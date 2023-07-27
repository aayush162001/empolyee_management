class RenameFieldName < ActiveRecord::Migration[7.0]
  def change
    rename_column :email_hierarchies, :to, :too
  end
end
