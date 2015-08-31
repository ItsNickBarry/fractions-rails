Fractions.Views.FractionsNew = Backbone.View.extend({
  template: JST['fractions_new'],
  className: 'fractions-object-element fractions-object-new fractions-object-fraction',

  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.founder = options.founder;
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();
    params.founder_id = this.founder.escape('id');
    params.founder_type = this.founder.class;
    // TODO make sure to add to founded_fractions collection, non necessarily the child/member fractions
    this.collection.create(params, { wait: true })
    this.render();
  }
});
