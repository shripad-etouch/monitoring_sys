class MonitoringSys.Views.UrlRequestResponsesNewView extends Backbone.View
 el: '#url_request_responses'

 template: JST["backbone/templates/url_request_responses/new"]

 events:
   "submit #new-url_request_response": "save"

 initialize: ->
   @render()

 render: ->
   @$el.html @template()

 save: (e) ->
   e.preventDefault()
   e.stopPropagation()
   url = $('#url').val()
   verb_id = $('#verb_id').val()
   request_header = $('#request_header').val()
   request_body = $('#request_body').val()
   response_header = $('#response_header').val()
   response_body = $('#response_body').val()
   timeout = $('#timeout').val()
   request_object_type_id = $('#request_object_type_id').val()
   model = new MonitoringSys.Models.UrlRequestResponse({url: url, verb_id: verb_id, request_header: request_header, request_body: request_body, response_header: response_header, response_body: response_body, timeout: timeout, request_object_type_id: request_object_type_id})
   @collection.create model,
        success: (url_request_response) =>
       @model = url_request_response
       window.location.hash = "/#{@model.id}"
