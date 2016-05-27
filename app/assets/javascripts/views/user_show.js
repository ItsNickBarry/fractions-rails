Fractions.Views.UserShow = Backbone.CompositeView.extend({
  template: JST['user_show'],

  initialize: function () {
    this.characters = this.model.characters();
    this.listenTo(this.model, 'sync', this.render);

    this.addSubviewForCharacters();
    if (this.model.get('id') === Fractions.session.currentUser().get('id')){
      this.addSubviewForCharactersNew();
    }
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
