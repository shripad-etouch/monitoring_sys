class Schedule
  include Mongoid::Document
  field :url_id, type: String
  field :schedule, type: Date
  field :success_status, type: String

  # Read all data for current minute from schedules table,
  # and run those jobs.

  def self.schedule_jobs
  	scheduler = Rufus::Scheduler.new
  	@all_schedules = Schedule.where(:schedule => (Time.now)..(Time.now + 59))
  	@urls =  UrlRequestResponse.find(@all_schedules.collect(&:url_id)).collect(&:url)
  	puts @urls
    @all_schedules.each_with_index do |sch, index|
        scheduler.at(sch["schedule"].to_s) do
        	response = HTTParty.get(@urls[index])
        	puts response
        end
    end
  end
end
