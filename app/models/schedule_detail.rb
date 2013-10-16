class ScheduleDetail
  include Mongoid::Document
  field :start_time, type: DateTime
  field :end_time, type: DateTime, :default => "Pending.."
  field :status_result, type: String
  field :response_message, type: String
  belongs_to :schedule
  delegate :schedule, :success_status, to: :schedule, prefix: true

  scope :include_associated_class, includes(:schedule)
end
