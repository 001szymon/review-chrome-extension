import Ember from 'ember';

export default Ember.Route.extend({
  background: Ember.inject.service(),
  afterModel: function() {
    this.get("background").run();
  }
});
