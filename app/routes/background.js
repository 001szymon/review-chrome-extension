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
    var self = this;
    chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
      console.log(sender);
      self.set('sender', sender);
      console.log(request);
      var id = request.commit;
      var token = projects.findBy('name', request.project).get('token');
      console.log({ id, token });
      sendResponse({ url: commitLookup.url() });
      // commitLookup.find(id, token).then(function(status) {
      //   sendResponse({ state: status });
      //   console.log('response sent', status);
      // });
    });
  }
});
