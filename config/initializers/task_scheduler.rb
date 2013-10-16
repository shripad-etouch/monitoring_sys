scheduler = Rufus::Scheduler.new

# Schedule job to run for a every minute,
# to read data from schedules table and check 
# for jobs to run.

scheduler.every("1m") do
   #Schedule.fetch_schedules_and_run
end 