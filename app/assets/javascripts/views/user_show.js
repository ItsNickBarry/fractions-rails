Fractions.Views.UserShow = Backbone.CompositeView.extend({
  template: JST['user_show'],
  className: 'fractions-object show user',

  events: {

  },

  initialize: function () {
    this.characters = this.model.characters();
    this.listenTo(this.model, 'sync', this.render);

    this.addSubviewForCharacters();
    this.addSubviewForCharactersNew();
  },

  render: function () {
    var content = this.template({ user: this.model });
    this.$el.html(content);
    this.attachSubviews()
    return this;
  },

  addSubviewForCharacters: function () {
    var view = new Fractions.Views.List({
      collection: this.characters
    });
    this.addSubview('#characters-list', view);
  },

  addSubviewForCharactersNew: function () {
    var view = new Fractions.Views.CharactersNew({
      userCharacters: this.characters
    });
    this.addSubview('#characters-new', view);
  },
});
