appUrl = ->
  localStorage["appUrl"]

appToken = ->
  localStorage["appToken"]

apiUrl = ->
  host = appUrl()
  if host[host.length-1] != '/'
    host += '/'
  token = appToken()
  host + "api/v1/review_check?token=" + token

getJSON = (url, successCallback)->
  xhr = new XMLHttpRequest()
  xhr.open("GET", url, true)
  xhr.onreadystatechange = ->
    if xhr.readyState == 4
      resp = JSON.parse(xhr.responseText)
      successCallback(resp)
  xhr.send()

print = (elId, text)->
  document.getElementById(elId).textContent = text

getJSON apiUrl(), (resp)->
  print('project_name', resp["project"]["name"])
  print('deadline', resp["deadline"])
  print('not_reviewed', resp["commits"]["by_state"]["not_reviewed"])
  print('auto_rejected', resp["commits"]["by_state"]["auto_rejected"])
