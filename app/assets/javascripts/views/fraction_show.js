Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST['fraction_show'],
  className: 'fractions-object show fraction',

  events: {

  },

  initialize: function () {
    this.foundedFractions = this.model.foundedFractions();
    this.children = this.model.children();
    this.electorates = this.model.electorates();
    this.positions = this.model.positions();
    this.regions = this.model.regions();

    this.listenTo(this.model, 'sync', this.render);

    // TODO add subviews in INITIALIZE for all composite views
    this.addSubviewForFoundedFractionsNew();
    // this.addSubviewForChildNew();
    this.addSubviewForElectoratesNew();
    this.addSubviewForPositionsNew();
    this.addSubviewForRegionsNew();

    // create list views for collections
    [
      [this.children, '#children-list'],
      [this.electorates, '#electorates-list'],
      [this.foundedFractions, '#founded-fractions-list'],
      [this.positions, '#positions-list'],
      [this.regions, '#regions-list']
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

  // addSubviewForChildNew: function () {
  //   var view = new Fractions.Views.FractionsNew({
  // collection: this.children,
  // founder: this.model });
  //   this.addSubview('#children-new', view);
  // },

  addSubviewForFoundedFractionsNew: function () {
    var view = new Fractions.Views.FractionsNew({
      childFractions: this.children,
      foundedFractions: this.foundedFractions,
      founder: this.model
    });
    this.addSubview('#founded-fractions-new', view);
  },

  addSubviewForElectoratesNew: function () {
    var view = new Fractions.Views.ElectoratesNew({
      collection: this.electorates,
      fraction: this.model
    });
    this.addSubview('#electorates-new', view);
  },

  addSubviewForPositionsNew: function () {
    var view = new Fractions.Views.PositionsNew({
      collection: this.positions,
      fraction: this.model
    });
    this.addSubview('#positions-new', view);
  },

  addSubviewForRegionsNew: function () {
    var view = new Fractions.Views.RegionsNew({
      collection: this.regions,
      fraction: this.model
    });
    this.addSubview('#regions-new', view);
  },
});
