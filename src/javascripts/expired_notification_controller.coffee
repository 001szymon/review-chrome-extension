class ExpiredNotificationController

  constructor: (options)->
    @urlBuilder = options?.urlBuilder || new UrlBuilder()
    @notifier = options?.notifier || new Notifier()

  getExpiredProjects: (callback)->
    $.getJSON @urlBuilder.tradeCheckUrl(), (resp)=>
      expired = @filterExpiredProjects(resp['projects'])
      callback(expired)

  filterExpiredProjects: (projects)->
    expired = []
    now = moment()
    oneMinuteAgo = moment().subtract('minute', 1)
    $.each projects, (_, project)->
      expirationTime = moment(project.expiration_date)
      expired.push(project) if oneMinuteAgo < expirationTime && expirationTime <= now
    expired

  perform: ->
    @getExpiredProjects (expired)=>
      $.each expired, (_, project)=>
        title = "#{project.name} just expired"
        description = "#{project.unreviewed_commits.by_state.pending} commits to review"
        @notifier.notify(title, description)

window.ExpiredNotificationController = ExpiredNotificationController
