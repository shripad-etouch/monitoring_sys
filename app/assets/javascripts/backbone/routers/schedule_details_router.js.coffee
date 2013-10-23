class MonitoringSys.Routers.ScheduleDetailsRouter extends Backbone.Router
  initialize: (options) ->
    @schedule_details = new MonitoringSys.Collections.ScheduleDetailsCollection()
    @schedule_details.reset options.schedule_details
  routes:
    "index": "index"
    ".*" : "index"
  
  index: ->
    @view = new MonitoringSys.Views.ScheduleDetails.IndexView(schedule_details: @schedule_details)
    $("#schedule_details").html(@view.render().el)

