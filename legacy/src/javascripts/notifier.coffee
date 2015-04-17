class Notifier

  constructor: (options)->
    @type = options?.type || 'basic'
    @iconUrl = options?.iconUrl || '/images/review-icon-128x128.png'

  notify: (title, message)->
    chrome.notifications.create '',
      type: @type
      iconUrl: @iconUrl
      title: title
      message: message
      , (id)-> console.log(id)

window.Notifier = Notifier
