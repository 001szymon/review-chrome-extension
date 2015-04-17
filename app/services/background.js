import Ember from 'ember';
const chrome = window.chrome;

export default Ember.Service.extend({
  run (projects) {
    chrome.omnibox.onInputChanged.addListener(
      this.suggestionsListener.bind(this, projects)
    );
  },
  suggestionsListener (projects, text, suggest) {
    suggest(this.transformProjectsToSuggestions(projects));
  },
  transformProjectsToSuggestions (projects) {
    return projects.toArray().map((project) => {
      const projectName = project.get('name');
      const reviewURL = `http://review.netguru.co/projects/${projectName}/commits`;
      return {
        content: reviewURL,
        description: projectName
      };
    });
  }
});
