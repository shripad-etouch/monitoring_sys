class ScheduleDetail
  include Mongoid::Document
  include SchedulerJob
  field :start_time, type: DateTime
  field :end_time, type: DateTime, :default => "Pending.."
  field :status_result, type: String
  field :response_message, type: String
  belongs_to :url_request_response
  scope :include_associated_classes, includes(:url_request_response)
  validates :start_time, :end_time, :status_result, 
            :response_messagev, :presence => true
end
