class MonitoringSys.Routers.UrlRequestResponsesRouter extends Backbone.Router

  initialize: (options) ->
    @url_request_responses = new MonitoringSys.Collections.UrlRequestResponsesCollection()
    @url_request_responses.reset options.url_request_responses

  routes:
    "index"       : "index"
    "new"         : "newUrlRequestResponse"
    ":id"         : "show"
    ":id/edit"    : "edit"
    ".*"          : "index"

  index: ->
    @view = new MonitoringSys.Views.UrlRequestResponsesIndexView({collection: @url_request_responses})

  newUrlRequestResponse: ->
    @view = new MonitoringSys.Views.UrlRequestResponsesNewView({collection: @url_request_responses})

  show: (id) ->
    url_request_response = @url_request_responses.get(id)
    @view = new MonitoringSys.Views.UrlRequestResponsesShowView({model: url_request_response})

  edit: (id) ->
    url_request_response = @url_request_responses.get(id)
    @view = new MonitoringSys.Views.UrlRequestResponsesEditView({model: url_request_response})