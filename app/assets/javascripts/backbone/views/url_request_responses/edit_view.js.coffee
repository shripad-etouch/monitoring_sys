class MonitoringSys.Views.UrlRequestResponsesEditView extends Backbone.View

  template: JST["backbone/templates/url_request_responses/edit"]

  el: '#url_request_responses'

  events:
    "submit #edit-url_request_response" : "update"

  model: MonitoringSys.Models.UrlRequestResponse

  initialize: ->
    @render()

  render: ->
    @$el.html @template(@model.toJSON())
    setTimeout (-> 
      $( -> 
        $('#datetimepicker2').datetimepicker({
          language: 'en',
          pick12HourFormat: true
        })
      )
    ), 0
    @

  update: (e) ->
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
    @model.save({url: url, http_verb: http_verb, timeout: timeout, object_type: object_type, request_header: request_header, request_body: request_body, expected_response_header: expected_response_header, expected_response_body: expected_response_body, time_to_run: time_to_run},
                error: (url_request_response, errors) =>
                    alert(errors)
                success: (url_request_response) =>
                    alert("success")
                    @model = url_request_response
                    window.location.hash = "/#{@model.id}")