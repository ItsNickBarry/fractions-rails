Fractions.Views.FractionsNew = Backbone.View.extend({
  template: JST['fractions_new'],
  className: 'fractions-object new fraction',

  events: {
    'submit form': 'submit'
  },

  initialize: function (options) {
    this.founder = options.founder;
    this.foundedFractions = options.foundedFractions;
    this.childFractions = options.childFractions;
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function (event) {
    event.preventDefault();

    var params = $(event.currentTarget).serializeJSON();
    params.fraction.founder_id = this.founder.get('id');
    params.fraction.founder_type = this.founder.class;
    // TODO make sure to add to child/member fractions, non necessarily the founded_fractions collection
    // TODO make sure to add to founded_fractions collection, non necessarily the child/member fractions
    this.foundedFractions.create(params, {
      wait: true,
      success: function (model) {
        if (params.fraction.make_child) {
          this.childFractions.add(model);
        }
      }.bind(this)
    });
    // var fraction = new Fractions.Models.Fraction(params['fraction']);
    //
    // fraction.save({}, {
    //   success: function () {
    //     this.foundedFractions.add(fraction);
    //     if (params.fraction.make_child) {
    //       this.childFractions.add(fraction);
    //     }
    //   }.bind(this)
    // });
    // this.render();
  }
});
