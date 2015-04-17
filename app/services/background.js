import Ember from 'ember';
const chrome = window.chrome;

export default Ember.Service.extend({
  run (projects) {
    this.resetDefaultSuggestion();
    chrome.omnibox.onInputChanged.addListener(
      this.suggestionsChangedListener.bind(this, projects)
    );

    chrome.omnibox.onInputEntered.addListener(
      this.suggestionsEnteredListener.bind(this)
    );
  },
  suggestionsChangedListener (projects, text, suggest) {
    suggest(this.transformProjectsToSuggestions(projects));
  },
  suggestionsEnteredListener (text) {
    this.navigate(text);
  },
  transformProjectsToSuggestions (projects) {
    return projects.toArray().map((project) => {
      const projectName = project.get('name');
      const reviewURL = `http://review.netguru.co/projects/${projectName}/commits`;
      return {
        content: reviewURL,
        description: `review: ${projectName}`
      };
    });
  },
  navigate (url) {
    chrome.tabs.query({active: true, currentWindow: true}, (tabs) => {
      chrome.tabs.update(tabs[0].id, {url: url});
    });
  },
  resetDefaultSuggestion () {
    chrome.omnibox.setDefaultSuggestion({
      description: 'Search project: %s'
    });
  }
});
