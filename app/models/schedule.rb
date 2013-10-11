class Schedule
  include Mongoid::Document
  field :url_id, type: Integer
  field :schedule, type: Date
  field :success_status, type: String

  # Read all data for current minute from schedules table,
  # and run those jobs.

  def self.schedule_jobs
  	scheduler = Rufus::Scheduler.new
  	@all_schedules = Schedule.where('schedule' => Time.now + 59)
    @all_schedules.each do |sch|
        scheduler.at(sch["schedule"].to_s) do
            puts "test message"
           #Scheduler code to run
        end
    end
  end
end
