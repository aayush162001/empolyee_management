class CreateEmailHierarchies < ActiveRecord::Migration[7.0]
  def change
    create_table :email_hierarchies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :to
      t.string :cc

      t.timestamps
    end
  end
end
