class MonitoringSys.Views.UrlRequestResponsesShowView extends Backbone.View

  template: JST["backbone/templates/url_request_responses/show"]

  el: '#url_request_responses'

  initialize: ->
    @render()

  render: ->
    @$el.html(@template(@model.toJSON()))
    @