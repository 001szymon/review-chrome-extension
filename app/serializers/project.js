import DS from 'ember-data';
import ENV from 'review-chrome-extension/config/environment';

export default DS.FirebaseSerializer.extend({
  extractSingle: function(store, type, payload, id, requestType) {
    var { name, token } = payload;
    payload.reviewUrl = ENV.reviewUrlTemplate.fmt(name.toLowerCase());
    payload.links = {
      commits: ENV.apiUrlTemplate.fmt(token)
    };
    return this._super.apply(this, [store, type, payload, id, requestType]);
  }
});
