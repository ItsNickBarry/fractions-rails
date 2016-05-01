Fractions.Views.RegionsExecutableForm = Backbone.View.extend({
  template: JST['regions_new_form'],
  className: 'fractions-object-element fractions-object-new fractions-object-region',

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
