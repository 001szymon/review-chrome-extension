import DS from 'ember-data';
import ENV from 'review-chrome-extension/config/environment';

export default DS.FirebaseSerializer.extend({
  extractSingle: function(store, type, payload, id, requestType) {
    var id = payload.project.name.toLowerCase();
    var pending = payload.commits.pending;
    var passed = payload.commits.passed;
    var rejected = payload.commits.rejected;
    var deadline = payload.deadline;
    return { id, pending, passed, rejected, deadline };
  }
});
