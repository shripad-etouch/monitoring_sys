
namespace :scheduler_task do
  desc "Run for every minute to schedule the checks"
  task per_minute_checks: :environment do
    #include Rufus::Scheduler
    scheduler = Rufus::Scheduler.new
    # Schedule job to run for a every minute,
    # to read data from schedules table and check 
    # for jobs to run.
    scheduler.every("1m") do
       schedule = ScheduleDetail.new
       schedule.fetch_schedules_and_run
    end
    scheduler.join
  end
end