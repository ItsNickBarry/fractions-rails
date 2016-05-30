Fractions.Views.SessionView = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model.currentCharacter(), 'change', this.render);
    this.render();
  },

  render: function () {
    var character = this.model.currentCharacter();
    if (character.get('id')) {
      $('span.current-character-header-link').html(
        '| ' + character.a(character.escape('name'))
      );
    }
    return this;
  },
});
