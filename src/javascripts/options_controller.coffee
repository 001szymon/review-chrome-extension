class OptionsController

  constructor: (options)->
    @optionsStorage = options?.optionsStorage || new OptionsStorage()

  saveOptions: ->
    @optionsStorage.setAppUrl @fromTextInput('app_url')
    @optionsStorage.setAppToken @fromTextInput('app_token')
    @setupPermissions()

  restoreOptions: ->
    @toTextInput 'app_url', @optionsStorage.appUrl()
    @toTextInput 'app_token', @optionsStorage.appToken()

  fromTextInput: (inputName)->
    $("[name='#{inputName}']").val()

  toTextInput: (inputName, value)->
    input = $("[name='#{inputName}']")
    input.val(value) if value?

  setupPermissions: ->
    appUrl = @optionsStorage.appUrl()
    @addPermissionsForHost(appUrl) if appUrl?

  addPermissionsForHost: (host) ->
    chrome.permissions.request(origins: [ host ])

  perform: ->
    @restoreOptions()
    $('#save').on 'click', (e)=>
      e.preventDefault()
      @saveOptions()

window.OptionsController = OptionsController
