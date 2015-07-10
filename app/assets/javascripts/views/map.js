Fractions.Views.Map = Backbone.View.extend({
  template: JST['map'],

  events: {
    // TODO on button clicks, tell this.map what to do
  },

  initialize: function (options) {
    // TODO this.map = options.map
    this.characters = this.model.characters();
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },
});
