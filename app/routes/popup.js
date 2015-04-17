import Ember from 'ember';
import KeyboardShortcuts from 'ember-keyboard-shortcuts/mixins/route';

export default Ember.Route.extend(KeyboardShortcuts, {
  actions: {
    focusSearch() {
      const $filterInput = Ember.$('#filter_projects');
      if(!$filterInput) {
        return;
      }

      $filterInput.focus();
    },
    clearSearch() {
      const $filterInput = Ember.$('#filter_projects');
      if(!$filterInput) {
        return;
      }

      this.set('controller.searchQuery', '');
      $filterInput.blur();
    },
    pressDown() {
      // select items in the future
    },
    pressUp() {
      // select items in the future
    }
  },
  keyboardShortcuts: {
    'command+l': 'focusSearch',
    'command+k': 'clearSearch',
    'down': 'pressDown',
    'up': 'pressUp'
  },
  model: function() {
    return this.store.findAll('project');
  }
});
