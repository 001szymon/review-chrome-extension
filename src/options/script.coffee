class OptionsController
  saveOptions: =>
    @optionFromTextInputToLocalStorage('app_url', 'appUrl')
    @optionFromTextInputToLocalStorage('app_token', 'appToken')
    @setupPermissions()

  restoreOptions: =>
    @optionFromLocalStorageToTextInput('app_url', 'appUrl')
    @optionFromLocalStorageToTextInput('app_token', 'appToken')

  optionFromTextInputToLocalStorage: (inputName, storageKey)->
    input = document.getElementsByName(inputName)[0]
    value = input.value
    localStorage[storageKey] = value if value?

  optionFromLocalStorageToTextInput: (inputName, storageKey)->
    value = localStorage[storageKey]
    input = document.getElementsByName(inputName)[0]
    input.value = value if value?

  setupPermissions: ->
    appUrl = localStorage["appUrl"]
    @addPermissionsForHost(appUrl) if appUrl?

  addPermissionsForHost: (host) ->
    if host[host.length-1] != '/'
      host += '/'
    chrome.permissions.request(origins: [ host ])

  perform: ->
    document.addEventListener('DOMContentLoaded', @restoreOptions)
    document.querySelector('#save').addEventListener('click', @saveOptions)

window.OptionsController = OptionsController
window.controller = new OptionsController()
window.controller.perform()
