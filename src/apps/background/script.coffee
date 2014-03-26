chrome.alarms.create("refreshBadge", periodInMinutes: 1)
chrome.alarms.onAlarm.addListener (alarm)->
  console.log(alarm.name)
  if alarm.name == "refreshBadge"
    badgeController = new BadgeController()
    badgeController.perform()
