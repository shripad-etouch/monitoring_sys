class MonitoringSys.Models.UrlRequestResponse extends Backbone.Model
  paramRoot: 'url_request_response'
  
class MonitoringSys.Collections.UrlRequestResponsesCollection extends Backbone.Collection
  model: MonitoringSys.Models.UrlRequestResponse
  url: '/url_request_responses'
