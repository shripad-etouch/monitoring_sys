class MonitoringSys.Models.UrlRequestResponse extends Backbone.RelationalModel
  
  paramRoot: 'url_request_response'

  relations: [
    type: Backbone.HasMany
    key: 'schedule_details'
    relatedModel: 'RailsBackboneRelational.Models.ScheduleDetail'
    collectionType: 'RailsBackboneRelational.Collections.ScheduleDetailsCollection'
    includeInJSON: false
    reverseRelation:
      key: 'url_request_response_id',
      includeInJSON: 'id'
  ]

  
class MonitoringSys.Collections.UrlRequestResponsesCollection extends Backbone.Collection
  model: MonitoringSys.Models.UrlRequestResponse
  url: '/url_request_responses'

