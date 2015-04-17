import DS from 'ember-data';

export default DS.Model.extend({
  pending: DS.attr('number'),
  passed: DS.attr('number'),
  rejected: DS.attr('number'),
  deadline: DS.attr('date')
});
