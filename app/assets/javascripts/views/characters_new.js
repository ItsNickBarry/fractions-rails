Fractions.Views.CharactersNew = Backbone.View.extend({
  template: JST['characters_new'],

  events: {
    'submit form': 'submit',
  },

  initialize: function (options) {
    this.userCharacters = options.userCharacters;
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();

    this.userCharacters.create(params, {
      wait: true,
      success: function (model) {
        if (Fractions.session.currentCharacter().isNew()) {
          Fractions.session.currentCharacter().set(model.attributes);
        }
      },
    });
  },
});
