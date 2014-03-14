# Use this file to easily define all of your cron jobs.
#

every :friday, :at => '11:59pm' do
  rake "vouchers:reset", :output => 'log/cron.log'
end

every 1.day, :at => '07:00pm' do
  rake "vouchers:check_expiring_soon", :output => 'log/cron.log'
end

every 1.day, :at => '07:30pm' do
  rake "mailers:daily_badges", :output => 'log/cron.log'
end

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

# Learn more: http://github.com/javan/whenever
