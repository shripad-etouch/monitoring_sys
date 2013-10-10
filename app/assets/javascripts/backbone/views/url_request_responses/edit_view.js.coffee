class MonitoringSys.Views.UrlRequestResponsesEditView extends Backbone.View

  template: JST["backbone/templates/url_request_responses/edit"]

  el: '#url_request_responses'

  events:
    "submit #edit-url_request_response" : "update"

  initialize: ->
    @render()

  render: ->
    @$el.html @template(@model.toJSON())
    @

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = $('#title').val()
    content = $('#content').val()
    @model.save({title: title, content: content},
                success: (url_request_response) =>
                    @model = url_request_response
                    window.location.hash = "/#{@model.id}")