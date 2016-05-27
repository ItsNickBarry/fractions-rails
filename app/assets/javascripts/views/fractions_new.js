Fractions.Views.FractionsNew = Backbone.View.extend({
  template: JST['fractions_new'],

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
    params.founder = { id: this.founder.class === 'Fraction' ? this.founder.get('id') : null };
    this.collection.create(params, {
      wait: true,
      success: function (model) {
        switch (this.founder.class) {
          case 'Character':
            this.founder.fractions().add(model);
            break;
          case 'Fraction':
            this.founder.childFractions().add(model);
            break;
        }
      }.bind(this),
    });
  },
});
