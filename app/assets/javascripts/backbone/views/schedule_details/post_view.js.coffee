MonitoringSys.Views.Posts ||= {}

class MonitoringSys.Views.ScheduleDetails.PostView extends Backbone.View
  template: JST["backbone/templates/schedule_details/post"]

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