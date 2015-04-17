import Ember from 'ember';
import ENV from 'review-chrome-extension/config/environment';

export default Ember.Service.extend({
  urlTemplate: ENV.commitUrlTemplate,
  find: function(id, token) {
    var url = this.get('urlTemplate').fmt(id, token);
    return Ember.$.ajax(url, 'GET').then(function(response) {
      return { status: response.state };
    });
  }
});
