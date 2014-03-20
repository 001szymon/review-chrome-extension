class OptionsController
  saveOptions: ->
    @optionFromTextInputToLocalStorage('app_url', 'appUrl')
    @optionFromTextInputToLocalStorage('app_token', 'appToken')
    @setupPermissions()

  restoreOptions: ->
    @optionFromLocalStorageToTextInput('app_url', 'appUrl')
    @optionFromLocalStorageToTextInput('app_token', 'appToken')

  optionFromTextInputToLocalStorage: (inputName, storageKey)->
    value = $("[name='#{inputName}']").val()
    localStorage[storageKey] = value if value?

  optionFromLocalStorageToTextInput: (inputName, storageKey)->
    value = localStorage[storageKey]
    input = $("[name='#{inputName}']")
    input.val(value) if value?

  setupPermissions: ->
    appUrl = localStorage["appUrl"]
    @addPermissionsForHost(appUrl) if appUrl?

  addPermissionsForHost: (host) ->
    if host[host.length-1] != '/'
      host += '/'
    chrome.permissions.request(origins: [ host ])

  perform: ->
    @restoreOptions()
    $('#save').on('click', => @saveOptions())

window.OptionsController = OptionsController
