class Schedule
  include Mongoid::Document
  field :url_id, type: Integer
  field :schedule, type: Date
  field :success_status, type: String
end
