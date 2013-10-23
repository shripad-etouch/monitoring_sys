MonitoringSys.Views.ScheduleDetails ||= {}

class MonitoringSys.Views.ScheduleDetails.IndexView extends Backbone.View
  template: JST["backbone/templates/schedule_details/index"]

  initialize: () ->
    @options.schedule_details.bind('reset', @addAll)

  addAll: () =>
    @options.schedule_details.each(@addOne)

  addOne: (schedule_detail) =>
    view = new MonitoringSys.Views.ScheduleDetails.ScheduleDetailView({model : schedule_detail})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(schedule_details: @options.schedule_details.toJSON() ))
    @addAll()
    setTimeout (-> $('#schedule-running-details').dataTable({aoColumns: [null, null, null, null, null, null, null, null]})), 0
    return this