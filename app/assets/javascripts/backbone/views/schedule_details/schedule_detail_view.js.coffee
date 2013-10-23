MonitoringSys.Views.ScheduleDetails ||= {}

class MonitoringSys.Views.ScheduleDetails.ScheduleDetailView extends Backbone.View
  template: JST["backbone/templates/schedule_details/schedule_detail"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    
    return this