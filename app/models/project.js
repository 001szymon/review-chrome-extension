import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr(),
  token: DS.attr(),
  reviewUrl: DS.attr(),
});
