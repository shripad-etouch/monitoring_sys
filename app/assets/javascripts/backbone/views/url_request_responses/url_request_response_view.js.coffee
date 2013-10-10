class MonitoringSys.Views.UrlRequestResponseView extends Backbone.View
  template: JST["backbone/templates/url_request_responses/url_request_response"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  render: ->
    @$el.html(@template(@model.toJSON()))
    return this