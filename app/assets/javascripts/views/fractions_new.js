Fractions.Views.FractionsNew = Backbone.View.extend({
  template: JST['fractions_new'],
  className: 'fractions-object new fraction',

  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.founder = options.founder;
    this.collection = options.collection;
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();
    params.founder = { id: this.founder ? this.founder.get('id') : null };
    this.collection.create(params, {
      wait: true,
      success: function (model) {
        if (this.founder) {
          founder.childFractions().add(model);
        }
      }.bind(this)
    });
  }
});
