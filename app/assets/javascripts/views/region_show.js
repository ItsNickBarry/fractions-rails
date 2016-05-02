Fractions.Views.RegionShow = Backbone.CompositeView.extend({
  template: JST['region_show'],
  className: 'fractions-object show region',

  events: {

  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({
      region: this.model
    });
    this.$el.html(content);
    return this;
  },
});
