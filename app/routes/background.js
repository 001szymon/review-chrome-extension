import Ember from 'ember';

export default Ember.Route.extend({
  background: Ember.inject.service(),
  commitLookup: Ember.inject.service(),
  model () {
    return this.store.find('project');
  },
  afterModel (projects) {
    this.setupListener();
    this.get('background').run(projects);
  },
  setupListener () {
    if (!chrome)
      return;
    chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
      console.log(request);
      sendResponse({ status: "accepted" });
    });
  }
});
