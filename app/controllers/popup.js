import Ember from 'ember';
const Fuse = window.Fuse;

export default Ember.Controller.extend({
  searchQuery: '',

  projects: Ember.computed.alias('model'),

  filteredProjects: Ember.computed('projects.[]', 'searchQuery', function() {
    const projects = this.get('projects');
    const searchQuery = this.get('searchQuery');

    if(!searchQuery.length) {
      return projects;
    }

    const fuse = this.get('fuse');

    return fuse.search(searchQuery);
  }),

  fuse: Ember.computed('projects.[]', function() {
    const projects = this.get('projects');
    const options = {
      caseSensitive: false,
      includeScore: false,
      shouldSort: true,
      threshold: 0.6,
      location: 0,
      distance: 100,
      maxPatternLength: 32,
      keys: ['_data.name']
    };

    return new Fuse(projects.toArray(), options);
  })
});
