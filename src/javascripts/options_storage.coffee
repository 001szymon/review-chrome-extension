class OptionsStorage

  appUrl: ->
    localStorage["appUrl"]

  setAppUrl: (value)->
    value += '/' if value[value.length-1] != '/'
    localStorage["appUrl"] = value

  setAppToken: (value)->
    localStorage["appToken"] = value

  appToken: ->
    localStorage["appToken"]

window.OptionsStorage = OptionsStorage
