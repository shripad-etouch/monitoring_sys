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
    url = $('#url').val()
    verb_id = $('#verb_id').val()
    timeout = $('#timeout').val()
    request_object_type_id = $('#request_object_type_id').val()
    @model.save({url: url, verb_id: verb_id, timeout: timeout, request_object_type_id: request_object_type_id},
                success: (url_request_response) =>
                    @model = url_request_response
                    window.location.hash = "/#{@model.id}")