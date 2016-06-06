Fractions.Views.UserShow = Backbone.CompositeView.extend({
  template: JST['user_show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);

    this.addSubview('#characters-list', new Fractions.Views.List({
      collection: this.model.characters()
    }));

    if (this.model.get('id') === Fractions.session.currentUser().get('id')){
      this.addSubview('#characters-new', new Fractions.Views.CharactersNew({
        collection: this.model.characters()
      }));
    }
  },

  render: function () {
    var content = this.template({ user: this.model });
    this.$el.html(content);
    this.attachSubviews()
    return this;
  },
});
