# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# binding.pry
DailyWorkReport.all.each  do |report|
    
    # binding.pry
    
    Attendance.create(user_id:report.user_id,present:1,attendance_date:report.current_date)
end
    
    