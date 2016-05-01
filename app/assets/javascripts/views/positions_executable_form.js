Fractions.Views.PositionsExecutableForm = Backbone.View.extend({
  template: JST['positions_new_form'],
  className: 'fractions-object-element fractions-object-new fractions-object-position',

  events: {
  },

  initialize: function (options) {
    this.fraction = options.fraction;
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },
});
