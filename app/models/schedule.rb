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
  	#all_schedules = Schedule.where(:schedule => (Time.now)..(Time.now + 59))
    all_schedules = Schedule.where(:schedule => (Time.now.utc - 1000000)..(Time.now.utc ))

    # Fetch all url's data for fetched schedules from database.
  	urls_data =  UrlRequestResponse.find(all_schedules.collect(&:url_request_response_id))

    # Iterate over fetched schedules from database 
    # and schedule the individual schedule to run at a given time. 
    urls_data.each_with_index do |url, index|
        #scheduler.at(all_schedules[index].schedule.to_s) do
        scheduler.every("10s") do
          puts url
          # Fetch the http request method type from verbs table.
          request_method_type = Verb.find(url["verb_id"])
          # Check if http request type is get or post and give appropriate call.
          if request_method_type["name"] == "GET" 
            # Http get request call
            puts request_method_type["name"]
            #check if request_header exsist, is yes set to headers in request.
            if !url["request_header"].blank?
          	  response = HTTParty.get(url["url"], :headers => url["request_header"])
            else
              response = HTTParty.get(url["url"])
            end

            
          #POST request      
          else
            if !url["request_header"].blank? && !url["request_body"].blank?
              response = HTTParty.post(url["url"], :query => url["request_header"], 
                                       :body => url["request_body"])
            elsif !url["request_header"].blank? && url["request_body"].blank?
              response = HTTParty.post(url["url"], :query => url["request_header"])
            elsif url["request_header"].blank? && !url["request_body"].blank?
              response = HTTParty.post(url["url"], :body => url["request_body"])
            else
              response = HTTParty.post(url["url"])
            end
          end

          # Save http response headers and response body to database on success.
          url.request_responses.create(:response_header => response.headers,
                                       :response_body => response.body)
        end
    end
    rescue => e
      p e.message 
  end
end
    
