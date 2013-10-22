class RunningDetailsController < ApplicationController
  def index
  	data = []
  	@schedule_details = ScheduleDetail.include_associated_classes#.paginate(page: params[:page], per_page: 5)
  	@schedule_details.each_with_index do |sch, index|
  		obj = {}
  		obj["start_time"] = sch["start_time"]
  		obj["end_time"] = sch["end_time"]
  		obj["status_result"] = sch["status_result"]
  		obj["response_message"] = sch["response_message"]
  		obj["url_request_response_id"] = sch["url_request_response_id"]
  		url_data= UrlRequestResponse.find(@schedule_details[index].url_request_response_id)
  		obj["url"] = url_data["url"]
  		obj["http_verb"] = url_data["http_verb"]
  		obj["object_type"] = url_data["object_type"]
  		obj["time_to_run"] = url_data["time_to_run"]
  		obj["timeout"] = url_data["timeout"]
  		data.push(obj)
  	end
  	@schedule_details = data
  end
end
