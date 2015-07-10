Fractions.Views.FractionsNew = Backbone.View.extend({
  template: JST['fractions_new'],
  className: 'fractions-object-element fractions-object-new fractions-object-fraction',

  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.character = options.character;
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    var view = this;
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();
    params.fraction.character_id = this.character.escape('id');
    this.collection.create(params['fraction'], { wait: true })
    this.render();
  }
});
