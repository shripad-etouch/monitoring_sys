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
   http_verb = $('#http_verb').val()
   timeout = $('#timeout').val()
   object_type = $('#object_type').val()
   request_header = $('#request_header').val()
   request_body = $('#request_body').val()
   expected_response_header = $('#expected_response_header').val()
   expected_response_body = $('#expected_response_body').val()
   time_to_run = $('#time_to_run').val()
   @model = new MonitoringSys.Models.UrlRequestResponse({url: url, http_verb: http_verb, timeout: timeout, object_type: object_type, request_header: request_header, request_body: request_body, expected_response_header: expected_response_header, expected_response_body: expected_response_body, time_to_run: time_to_run})

   @collection.create @model,
        success: (url_request_response) =>
          @model = url_request_response
          window.location.hash = "/#{@model.id}"

