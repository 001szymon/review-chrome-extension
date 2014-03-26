class BadgeController

  constructor: (options)->
    @urlBuilder = options?.urlBuilder || new UrlBuilder()

  refreshExpiredCount: (callback)->
    $.getJSON @urlBuilder.tradeCheckUrl(), (resp)=>
      count = @countExpired(resp['projects'])
      callback(count)

  countExpired: (projects)->
    dates = @pluckExpirationDates(projects)
    expiredDates = @filterExpired(dates)
    expiredDates.length

  pluckExpirationDates: (projects)->
    $.map(projects, (project)-> project.expiration_date)

  filterExpired: (dates)->
    expired = []
    currentDate = new Date()
    $.each dates, (date)->
      expired.push(date) if currentDate > (new Date(date))
    expired

  updateBadge: (count)->
    text = @formatBadge(count)
    chrome.browserAction.setBadgeText(text: text)

  formatBadge: (count)->
    return "" if count == 0
    String(count)

  perform: ->
    @refreshExpiredCount((count)=> @updateBadge(count))

window.BadgeController = BadgeController
