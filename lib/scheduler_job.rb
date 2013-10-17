##Scheduler  common code
module SchedulerJob
  # Read all data for current minute from schedules table,
  # and run those jobs. 
  def fetch_schedules_and_run
    # Create instance of rufus scheduler
    scheduler = Rufus::Scheduler.new

    # Fetch all schedules from database for the next 59 seconds.
  	urls_data = UrlRequestResponse.where(:time_to_run => (Time.now)..(Time.now + 59)) #During testing comment this line
    #urls_data = UrlRequestResponse.where(:time_to_run => (Time.now - 500000)..(Time.now)) #During testing uncomment this line

    # Iterate over fetched schedules from database 
    # and schedule the individual schedule to run at a given time. 
    urls_data.each do |obj|
      schedule_job(obj, scheduler, obj.time_to_run)
    end
    
  end

  # Shedule individual jobs.
  def schedule_job(obj, scheduler, schedule_at)
    scheduler.at(schedule_at.to_s) do #During testing comment this line
      # Same job schedule it run to after one hour
      obj.update_attributes(:time_to_run => Time.parse(obj.time_to_run.to_s) + 60 * 60) #1 hour
      #scheduler.every("10s") do #During testing uncomment this line
      # Job execution start time.
      schedule_detail = ScheduleDetail.create(:start_time => Time.now, :url_request_response => obj)
      # Here adding one custom header for each request, 
      # which will be used to check response against the request.
      custom_header = obj["request_header"]
      if custom_header.blank?
          custom_header = "{'X-Schedule-for' => \'#{schedule_detail['_id']},#{obj['_id']}\'}"
      else
          custom_header = custom_header[0...-1] + ", 'X-Schedule-for' => \'" + schedule_detail['_id'] + obj['_id'] + "\'}"
      end
      # Check if http request type is get or post and give appropriate call.
      if obj["http_verb"] == "GET" 
        # Http get request call
        response = HTTParty.get(obj["url"], :headers => eval(custom_header))
        
      #POST request      
      else
        # if both request header and request body exists add it to post call.
        if !custom_header.blank? && !obj["request_body"].blank?
          response = HTTParty.post(obj["url"], :headers => eval(custom_header), 
                                   :query => eval(obj["request_body"]))

        # if only request header exists and request body does not exists,
        # add only request headers to post call.
        elsif !custom_header.blank? && obj["request_body"].blank?
          response = HTTParty.post(obj["url"], :headrs => eval(custom_header))
        end
      end
      # Update database on success
      update_database_on_success(response)
    end

    rescue Timeout::Error
      message = "Timed out request to #{obj["url"]}, will be retrird after 5 minute"
      handle_errors(message, obj, scheduler, schedule_detail)
    rescue
      message = "Unable to serve the request to #{obj["url"]}, will be retrird after 5 minutes"
      handle_errors(message, obj, scheduler, schedule_detail)
  end

  # This method will take care of inserting and updating database on success.
  def update_database_on_success(response)
      # read the X-Schedule-for from request headers of response object.
      custom_header =  response.request.instance_variable_get(:@options)[:headers]["X-Schedule-for"]
      # Fetch respective record from schedule_details table and update with other fields.
      schedule_detail = ScheduleDetail.find(custom_header.split(",")[0])
      # Fetch the UrlRequestResponse record for which this req. was sent.
      current_url_data = UrlRequestResponse.find(custom_header.split(",")[1])
      # Check the response header and response body mathces with the 
      # expected response header and response body and 
      # Update schedule_details table accordingly.
      if !response.headers.eql? current_url_data.expected_response_header || 
         !response.body.eql? current_url_data.expected_response_body
        schedule_detail.update_attributes(:end_time => Time.now, 
                                          :status_result => !response.headers["status"].nil? ? response.headers["status"] : 
                                                                                               "Response status is empty",
                                          :response_message => "Request failed")
      else
        schedule_detail.update_attributes(:end_time => Time.now, 
                                          :status_result => "As expected",
                                          :response_message => "Request succeeded")
      end  

  end

  # Handle error responses and re-schedule job after 5 minutes.
  def handle_errors(message, obj, scheduler, schedule_detail)
    # Update schedule_details table once response is received.
    schedule_detail.update_attributes(:end_time => Time.now, 
                                      :status_result => "Failed",
                                      :response_message => message)
    # Re-schedule after 5 minutes.
    schedule_job(obj, scheduler, Time.parse(obj.time_to_run.to_s) + 60 * 5) # 5 minutes
end