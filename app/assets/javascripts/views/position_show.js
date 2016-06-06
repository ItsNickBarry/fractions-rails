Fractions.Views.PositionShow = Backbone.CompositeView.extend({
  template: JST['position_show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);

    this.addSubview('#characters-list', new Fractions.Views.List({
      collection: this.model.members()
    }));
  },

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },
});
