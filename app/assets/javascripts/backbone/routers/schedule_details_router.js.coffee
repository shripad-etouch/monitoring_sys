class MonitoringSys.Routers.ScheduleDetailsRouter extends Backbone.Router
  initialize: (options) ->
    @running_details = new MonitoringSys.Collections.ScheduleDetailsCollection()
    @running_details.reset options.schedule_details
  routes:
    "index": "index"
    ".*"   : "index"
  
  index: ->
    debugger
    @view = new MonitoringSys.Views.ScheduleDetails.IndexView(running_details: @running_details)
    $("#schedule_details").html(@view.render().el)

