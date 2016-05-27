Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST['fraction_show'],

  initialize: function () {
    this.foundedFractions = this.model.foundedFractions();
    this.children = this.model.children();
    this.electorates = this.model.electorates();
    this.positions = this.model.positions();
    this.regions = this.model.regions();

    this.listenTo(this.model, 'sync', this.render);
    this.addSubviewForFoundedFractionsNew();

    // create list views for collections
    [
      [this.children, '#children-list'],
      [this.foundedFractions, '#founded-fractions-list'],
    ].forEach(function (pair) {
      var view = new Fractions.Views.List({
        collection: pair[0]
      });
      this.addSubview(pair[1], view);
    }.bind(this))
  },

  render: function () {
    var content = this.template({
      fraction: this.model
    });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addSubviewForFoundedFractionsNew: function () {
    var view = new Fractions.Views.FractionsNew({
      collection: this.foundedFractions,
      founder: this.model
    });
    this.addSubview('#founded-fractions-new', view);
  },
});
