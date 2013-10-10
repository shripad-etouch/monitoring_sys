class ScheduleDetail
  include Mongoid::Document
  field :url_id, type: Integer
  field :executed_time, type: Date
end
