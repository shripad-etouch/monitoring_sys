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
   timeout = $('#timeout').val()
   request_object_type_id = $('#request_object_type_id').val()
   model = new MonitoringSys.Models.UrlRequestResponse({url: url, verb_id: verb_id, timeout: timeout, request_object_type_id: request_object_type_id})
   @collection.create model,
        success: (url_request_response) =>
       @model = url_request_response
       window.location.hash = "/#{@model.id}"
