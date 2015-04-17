import Ember from 'ember';

export default Ember.Route.extend({
  background: Ember.inject.service(),
  commitLookup: Ember.inject.service(),
  model () {
    return this.store.find('project');
  },
  afterModel (projects) {
    this.setupListener(projects);
    this.get('background').run(projects);
  },
  setupListener (projects) {
    if (!chrome)
      return;
    var commitLookup = this.get('commitLookup');
    chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
      console.log(request);
      var id = request.commit;
      var token = projects.findBy('name', request.project).get('token');
      console.log({ id, token });
      commitLookup.find(id, token).then(status => {
        sendResponse({ state: status });
      });
    });
  }
});
