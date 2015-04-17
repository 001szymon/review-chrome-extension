import Ember from 'ember';
const chrome = window.chrome;
const Fuse = window.Fuse;

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
    const suggestions = this.transformProjectsToSuggestions(projects);
    const fuse = this.initFuse(suggestions);

    suggest(fuse.search(text));
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
  },
  initFuse (list = []) {
    const options = {
      caseSensitive: false,
      includeScore: false,
      shouldSort: true,
      threshold: 0.6,
      location: 0,
      distance: 100,
      maxPatternLength: 32,
      keys: ["description"]
    };

    return new Fuse(list, options);
  }
});
