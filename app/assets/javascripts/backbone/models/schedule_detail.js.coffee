class MonitoringSys.Models.ScheduleDetail extends Backbone.Model
  paramRoot: 'schedule_detail'

  defaults:
    url: null
    http_verb: null
    object_type: null
    time_to_run: null
    timeout: null
    start_time: null
    end_time: null
    status_result: null

class MonitoringSys.Collections.ScheduleDetailsCollection extends Backbone.Collection
  model: MonitoringSys.Models.ScheduleDetail
  url: '/running_details'
