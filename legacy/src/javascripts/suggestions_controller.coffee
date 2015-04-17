class SuggestionsController

  constructor: (options)->
    @urlBuilder = options?.urlBuilder || new UrlBuilder()

  perform: (text, suggest) ->
    @getSuggestionsFor text, (suggestions)->
      suggest(suggestions)

  getSuggestionsFor: (text, callback)->
    $.getJSON @urlBuilder.fuzzyUrl(), (resp)=>
      suggestions = @transformResponse(resp['suggestions'])
      callback(suggestions)

  transformResponse: (rawSuggestions)->
    $.map rawSuggestions, (raw)->
      content: raw.url
      description: "#{raw.name}: #{raw.status} (#{raw.pending})"

window.SuggestionsController = SuggestionsController
