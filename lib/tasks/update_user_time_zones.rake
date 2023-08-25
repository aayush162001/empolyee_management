namespace :users do
    desc "Update time zones for existing users to Asia/Kolkata (IST)"
    task update_time_zones: :environment do
        
        binding.pry
        
      User.where(time_zone: nil).find_each do |user|
        user.update(time_zone: Time.zone.name)
        puts "Updated time zone for User ##{user.id}"
      end
      puts "Time zones updated for all users."
    end
end