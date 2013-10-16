class Schedule
  include Mongoid::Document
  #field :url_id, type: String
  field :schedule, type: DateTime
  field :success_status, type: String
  belongs_to :url_request_response
  # Read all data for current minute from schedules table,
  # and run those jobs.

  def self.fetch_schedules_and_run
    puts "in..................................."
    # Create instance of rufus scheduler
    scheduler = Rufus::Scheduler.new
    # Fetch all schedules from database for the next 59 seconds.
  	all_schedules = Schedule.where(:schedule => (Time.now)..(Time.now + 59)) #During testing comment this line
    #all_schedules = Schedule.where(:schedule => (Time.now - 500000)..(Time.now)) #During testing uncomment this line

    # Array of objects, each individual object contains one to one mapping of
    # schedule object and url object.
  	urls_data =  Array.new

    # Here fetching urls individually for each schedule,
    # because same url may repeat for another schedule.

    all_schedules.each do |sch|
      obj = {}
      obj["schedule_data"] = sch
      obj["url_data"] = UrlRequestResponse.find(sch["url_request_response_id"])
      urls_data.push(obj)
    end

    # Iterate over fetched schedules from database 
    # and schedule the individual schedule to run at a given time. 
    urls_data.each do |obj|
      self.schedule_job(obj, scheduler, obj["schedule_data"]["schedule"])
    end
    
  end

  # Shedule individual jobs.
  def self.schedule_job(obj, scheduler, schedule_at)
    scheduler.at(schedule_at.to_s) do #During testing comment this line
    #scheduler.every("10s") do #During testing uncomment this line
      # Job execution start time.
      ScheduleDetail.create(:start_time => Time.now, :schedule => obj["schedule_data"])
      # Fetch the http request method type from verbs table.
      request_method_type = Verb.find(obj["url_data"]["verb_id"])

      # Here adding one custom header for each request, 
      # which will be used to check response against the request.
      custom_header = obj["url_data"]["request_header"]
      if custom_header.blank?
          custom_header = 
            "{'X-Schedule-for' => \'#{obj['schedule_data']['_id']},#{obj["url_data"]['_id']}\'}"
      else
          custom_header = 
            custom_header[0...-1] + \
            ", 'X-Schedule-for' => \'" + obj["schedule_data"]["_id"] + "," + obj["url_data"]['_id'] + "\'}"
      end
      puts request_method_type["name"]
      puts obj["url_data"]["request_header"]
      puts "custom_header"
      puts custom_header
      # Check if http request type is get or post and give appropriate call.
      if request_method_type["name"] == "GET" 
        # Http get request call
        response = HTTParty.get(obj["url_data"]["url"], :headers => eval(custom_header))
        
      #POST request      
      else
        # if both request header and request body exists add it to post call.
        if !custom_header.blank? && !obj["url_data"]["request_body"].blank?
          response = HTTParty.post(obj["url_data"]["url"], :headers => eval(custom_header), 
                                   :query => eval(obj["url_data"]["request_body"]))

        # if only request header exists and request body does not exists,
        # add only request headers to post call.
        elsif !custom_header.blank? && obj["url_data"]["request_body"].blank?
          response = HTTParty.post(obj["url_data"]["url"], :headrs => eval(custom_header))
        end
      end

      # Update database on success
      self.update_database_on_success(response)
    end
    rescue Timeout::Error
      message = "Timed out request to #{obj["url_data"]["url"]}, will be retrird after 5 minute"
      self.handle_errors(message, obj, scheduler)
    rescue
      message = "Unable to serve the request to #{obj["url_data"]["url"]}, will be retrird after 5 minutes"
      self.handle_errors(message, obj, scheduler)
  end

  # This method will take care of inserting and updating database on success.
  def self.update_database_on_success(response)
      # read the X-Schedule-for from request headers of response object.
      custom_header =  response.request.instance_variable_get(:@options)[:headers]["X-Schedule-for"]
      # Fetch respective record from schedule_details table and update with other fields.
      schedule_detail = ScheduleDetail.where(:schedule_id => custom_header.split(",")[0])
      puts "before"
      puts schedule_detail[0]
      # Update schedule_details table once response is received.
      schedule_detail[0].update_attributes(:end_time => Time.now, 
                                           :status_result => response.headers["status"],
                                           :response_message => "Request succeeded") 
      puts "after"
      puts schedule_detail[0]
      # Save http response headers and response body to database on success.
      RequestResponse.create(:response_header => response.headers,
                             :response_body => response.body,
                             :schedule => schedule_detail[0],
                             :url_request_response => UrlRequestResponse.find(custom_header.split(",")[1]))
  end

  # Handle error responses and re-schedule job after 5 minutes.
  def self.handle_errors(message, obj, scheduler)
    # Fetch respective record from schedule_details table and update with other fields.
    schedule_detail = ScheduleDetail.where(:schedule_id => obj["schedule_data"]["_id"])
    # Update schedule_details table once response is received.
    schedule_detail[0].update_attributes(:end_time => Time.now, 
                                         :status_result => "Failed",
                                         :response_message => message)
    # Re-schedule after 5 minutes.
    self.schedule_job(obj, scheduler, obj["schedule_data"]["schedule"] + 300)
  end

end
    
