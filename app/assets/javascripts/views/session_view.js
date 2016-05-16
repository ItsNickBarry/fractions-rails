Fractions.Views.SessionView = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model.currentCharacter(), 'change', this.render);
  },

  render: function () {
    $('span.current-character-header-link').html(
      '| ' + this.model.currentCharacter().a(
        this.model.currentCharacter().escape('name')
      )
    );
    return this;
  },
});
