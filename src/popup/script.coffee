class PopupController
  appUrl: ->
    localStorage["appUrl"]

  appToken: ->
    localStorage["appToken"]

  apiUrl: ->
    host = @appUrl()
    if host[host.length-1] != '/'
      host += '/'
    token = @appToken()
    "#{host}api/v1/review_check?token=#{token}"

  perform: ->
    $.getJSON @apiUrl(), (resp)->
      $('#project_name').text(resp["project"]["name"])
      $('#deadline').text(resp["deadline"])
      $('#not_reviewed').text(resp["commits"]["by_state"]["not_reviewed"])
      $('#auto_rejected').text(resp["commits"]["by_state"]["auto_rejected"])

window.PopupController = PopupController
window.controller = new PopupController()
window.controller.perform()
