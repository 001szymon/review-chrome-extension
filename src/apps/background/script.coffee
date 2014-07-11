chrome.alarms.create("refreshBadge", periodInMinutes: 1)
chrome.alarms.onAlarm.addListener (alarm)->
  console.log(alarm.name)
  if alarm.name == "refreshBadge"
    badgeController = new BadgeController()
    badgeController.perform()

chrome.omnibox.onInputChanged.addListener (text, suggest)->
  suggestionsController = new SuggestionsController()
  suggestionsController.perform(text, suggest)

chrome.omnibox.onInputEntered.addListener (text)->
  chrome.tabs.query active: true, currentWindow: true, (tabs)->
    chrome.tabs.update(tabs[0].id, url: text)
