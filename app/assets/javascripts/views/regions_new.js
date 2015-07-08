Fractions.Views.RegionsNew = Backbone.View.extend({
  template: JST['regions_new'],
  className: 'fractions-object-element fractions-object-new fractions-object-region',

  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.fraction = options.fraction;
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    var view = this;
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();
    params.region.fraction_id = this.fraction.escape('id');
    this.collection.create(params['region'], { wait: true })
    this.render();
  }
});
