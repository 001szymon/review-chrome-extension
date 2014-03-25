class PopupController

  constructor: (options)->
    @urlBuilder = options?.urlBuilder || new UrlBuilder()

  projectToTableRow: (project)->
    $tableRow = $('<tr>')
    $.each [
      project['name'],
      project['expiration_date'],
      project['unreviewed_commits']['by_state']['pending'],
      project['unreviewed_commits']['by_state']['auto_rejected'],
    ], (_, value)=>
      $tableRow.append @cellFactory(value)
    $tableRow.append($('<td>').append(@makeLink(project['url'])))
    $tableRow

  cellFactory: (content)->
    $('<td>').text(content)

  makeLink: (url)->
    $('<a target="_blank">').text(url).attr('href', url)

  renderProjects: (projects)->
    $tableBody = $('tbody')
    $.each projects, (_, project)=>
      $tableBody.append(@projectToTableRow(project))

  perform: ->
    $.getJSON @urlBuilder.tradeCheckUrl(), (resp)=>
      @renderProjects(resp['projects'])

window.PopupController = PopupController
