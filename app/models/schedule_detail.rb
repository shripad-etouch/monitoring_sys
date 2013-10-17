class ScheduleDetail
  include Mongoid::Document
  include SchedulerJob
  field :start_time, type: DateTime
  field :end_time, type: DateTime, :default => "Pending.."
  field :status_result, type: String
  field :response_message, type: String
  belongs_to :url_request_response
end
