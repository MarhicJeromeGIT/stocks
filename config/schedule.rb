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
#
# update crontab :
# whenever --update-crontab
#
# Learn more: http://github.com/javan/whenever

# Every day of the week (mon to fri), every one hour at hour:5 min from 8 am to 6pm go 
# through my alarms and check if we should trigger them
# TODO make sure that my serveur hour is Paris hour !
# crontab : min hour day/month month day/week
every '5 8-6 * * 1-5' do
  rake "alerts:check"
end