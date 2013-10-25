class MonitoringSys.Views.UrlRequestResponsesNewView extends Backbone.View
 el: '#url_request_responses'

 template: JST["backbone/templates/url_request_responses/new"]

 events:
   "submit #new-url_request_response": "save"

 initialize: ->
   @render()

 render: ->
  @$el.html @template()
  setTimeout (-> 
    $( -> 
      $('#datetimepicker1').datetimepicker({
        language: 'en',
        pick12HourFormat: true
      })
    )
  ), 0

   

 save: (e) ->
   e.preventDefault()
   e.stopPropagation()
   url = $('#url').val()
   http_verb = $('#http_verb').val()
   timeout = $('#timeout').val()
   object_type = $('#object_type').val()
   index_val = parseInt($(".request_headers_div").last().attr("index_val"))
   actual_header = "{"
   for i in [0..index_val] by 1
    key = "request_header_key_"+i
    val = "request_header_value_"+i
    actual_header += "{"+$("#"+key).val()+"=>"+"'"+$("#"+val).val()+"'"+"}"
    if(i!=index_val)
      actual_header += ","
    else
      actual_header += "}"
   alert(actual_header);
   asadsadasdasdsd
   request_header = actual_header
   request_body = $('#request_body').val()
   expected_response_header = $('#expected_response_header').val()
   expected_response_body = $('#expected_response_body').val()
   time_to_run = $('#time_to_run').val()
   @model = new MonitoringSys.Models.UrlRequestResponse({url: url, http_verb: http_verb, timeout: timeout, object_type: object_type, request_header: request_header, request_body: request_body, expected_response_header: expected_response_header, expected_response_body: expected_response_body, time_to_run: time_to_run})
   alert("create called")
   @collection.create @model,
        success: (url_request_response) =>
          @model = url_request_response
          window.location.hash = "/#{@model.id}"

