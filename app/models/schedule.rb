class Schedule 
  include Mongoid::Document
  include SchedulerJob
  field :schedule, type: DateTime
  field :success_status, type: String
  belongs_to :url_request_response
end
    
