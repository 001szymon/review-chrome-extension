import Ember from 'ember';

export default Ember.Route.extend({
  background: Ember.inject.service(),
  model () {
    return this.store.find('project');
  },
  afterModel (projects) {
    this.get('background').run(projects);
  }
});
