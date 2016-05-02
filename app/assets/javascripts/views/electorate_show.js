Fractions.Views.ElectorateShow = Backbone.CompositeView.extend({
  template: JST['electorate_show'],
  className: 'fractions-object show electorate',

  events: {

  },

  initialize: function () {
    this.characters = this.model.characters();
    this.listenTo(this.model, 'sync', this.render);

    this.addSubviewForCharacters();
  },

  render: function () {
    var content = this.template({ electorate: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubviewForCharacters: function () {
    var view = new Fractions.Views.List({
      collection: this.characters
    });
    this.addSubview('#characters-list', view);
  },
});
