Fractions.Views.PositionsNew = Backbone.View.extend({
  template: JST["positions_new"],
  // tagName: 'form',
  // className: 'form-list-item',

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
    params.position.fraction_id = this.fraction.escape('id');
    this.collection.create(params["position"], { wait: true })
    this.render();
  }
});
