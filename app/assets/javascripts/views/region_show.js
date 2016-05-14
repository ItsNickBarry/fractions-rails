Fractions.Views.RegionShow = Backbone.CompositeView.extend({
  template: JST['region_show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);

    // land auth positions list
  },

  render: function () {
    var content = this.template({
      model: this.model
    });
    this.$el.html(content);
    return this;
  },
});
