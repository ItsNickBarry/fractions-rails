Fractions.Views.CharactersNew = Backbone.View.extend({
  template: JST['characters_new'],
  className: 'fractions-object-element fractions-object-new fractions-object-character',

  events: {
    'submit form': 'submit'
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
      wait: true
    });
  }
});
