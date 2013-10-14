class Schedule
  include Mongoid::Document
  #field :url_id, type: String
  field :schedule, type: DateTime
  field :success_status, type: String
  belongs_to :url_request_response
  # Read all data for current minute from schedules table,
  # and run those jobs.

  def self.schedule_jobs

    # Create instance of rufus scheduler
  	scheduler = Rufus::Scheduler.new

    # Fetch all schedules from database for the next 59 seconds.
  	all_schedules = Schedule.where(:schedule => (Time.now)..(Time.now + 59))

    # Fetch all url's data for fetched schedules from database.
  	urls_data =  UrlRequestResponse.find(all_schedules.collect(&:url_request_response_id))

    # Iterate over fetched schedules from database 
    # and schedule the individual schedule to run at a given time. 
    urls_data.each_with_index do |url, index|
        scheduler.at(all_schedules[index].schedule.to_s) do
          # Fetch the http request method type from verbs table.
          request_method_type = Verb.find(url["verb_id"])
          # Check if http request type is get or post and give appropriate call.
          if request_method_type["name"] == "GET" 
            # Http get request call
          	response = HTTParty.get(url["url"])

            # Save http response headers and response body to database on success.
            request_response = RequestResponse.where(:url_request_response => url["id"])
            request_response.update_attributes(:response_header => response.headers,
                                              :response_body => response.body)

            #TODO- explicit checks for http error codes for retry logic.
            rescue => e
              # TODO- Retry logic
              p e.message        
          else
            # TODO - Http post request call
          end
        	puts response
        end
    end
    rescue => e
      p e.message 
  end
end
    
