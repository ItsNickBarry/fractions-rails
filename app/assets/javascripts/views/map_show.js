Fractions.Views.MapShow = Backbone.CompositeView.extend({
  template: JST['map_show'],

  events: {
    // TODO on button clicks, tell this.map what to do
  },

  initialize: function (options) {
    // Backbone.history.navigate('//map', { trigger: false });
  },

  render: function () {
    var content = this.template({ map: this.map });
    this.$el.html(content);

    var d3El = d3.selectAll(this.$el.find('#map').toArray());
    this.map = new Fractions.Map(d3El);
    this.map.render();
    
    return this;
  },
});
