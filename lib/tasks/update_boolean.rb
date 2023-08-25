namespace :update_boolean do
    desc "Update existing data in your_column to true"
    task update_boolean_data: :environment do
      User.update_all(is_active: true)
    end
  end