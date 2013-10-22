MonitoringSys.Views.ScheduleDetails ||= {}

class MonitoringSys.Views.ScheduleDetails.IndexView extends Backbone.View
  template: JST["backbone/templates/schedule_details/index"]

  initialize: () ->
    @options.running_details.bind('reset', @addAll)

  addAll: () =>
    @options.running_details.each(@addOne)

  addOne: (running_detail) =>
    view = new MonitoringSys.Views.ScheduleDetails.PostView({model : running_detail})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(running_details: @options.running_details.toJSON() ))
    @addAll()

    return this
