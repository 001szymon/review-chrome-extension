class UrlBuilder

  constructor: (options)->
    @optionsStorage = options?.optionsStorage || new OptionsStorage()

  tradeCheckUrl: ->
    @decorate "api/v1/trade_check"

  decorate: (url)->
    host = @optionsStorage.appUrl()
    token = @optionsStorage.appToken()
    "#{host}#{url}?token=#{token}"

window.UrlBuilder = UrlBuilder
