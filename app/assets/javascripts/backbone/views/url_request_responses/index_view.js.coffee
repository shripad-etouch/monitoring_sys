class MonitoringSys.Views.UrlRequestResponsesIndexView extends Backbone.View

	el: '#url_request_responses'

	template: JST["backbone/templates/url_request_responses/index"]

	initialize: ->
	    @render()
	    @addAll()

	addAll: ->
	    @collection.forEach(@addOne, @)

	addOne: (model) ->
	    @view = new MonitoringSys.Views.UrlRequestResponseView({model: model})
	    @$el.find('tbody').append @view.render().el

	render: ->
	    @$el.html @template()
	    setTimeout (-> $("table#url-request-response a").addClass("btn btn-link")),0
	    @