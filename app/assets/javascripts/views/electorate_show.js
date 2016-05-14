Fractions.Views.ElectorateShow = Backbone.CompositeView.extend({
  template: JST['electorate_show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);

    this.addSubviewForPositions();
  },

  render: function () {
    var content = this.template({ electorate: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubviewForPositions: function () {
    var view = new Fractions.Views.List({
      collection: this.model.members()
    });
    this.addSubview('#positions-list', view);
  },
});
