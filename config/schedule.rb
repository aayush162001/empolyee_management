# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
#Clear cron: crontab -r
#update cron: whenever --update-crontab
#update cron development: whenever --update-crontab --set environment='development'

set :output, './log/cron.log'

every 1.minutes do
    runner "puts 'Hello, world'"
end

every [:tuesday, :wednesday, :thursday, :friday, :saturday], at: '12pm' do
    runner "CheckInOut.scheduled_check_out_mail"
end

every [:tuesday, :wednesday, :thursday, :friday, :saturday], at: '12pm' do
    runner "DailyWorkReport.scheduled_report_mail"
end

every [:tuesday, :wednesday, :thursday, :friday, :saturday], at: '12pm' do
    runner "CheckInOut.scheduled_check_in_mail"
end

# every 0 13 * * 2-6, at: '12pm' do
#     runner "DailyWorkReport."
# end

# Learn more: http://github.com/javan/whenever