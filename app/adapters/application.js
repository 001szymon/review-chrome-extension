import config from '../config/environment';
import Firebase from 'firebase';
import FirebaseAdapter from 'emberfire/adapters/firebase';

export default FirebaseAdapter.extend({
  firebase: new Firebase(config.firebase),
  findBelongsTo: function(store, snapshot, url, relationship) {
    return Ember.$.ajax(url, 'GET');
  }
});
