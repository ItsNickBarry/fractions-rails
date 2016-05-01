Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST['fraction_show'],
  className: 'fractions-object-element fractions-object-show fractions-object-fraction',

  events: {

  },

  initialize: function () {
    this.foundedFractions = this.model.foundedFractions();
    this.children = this.model.children();
    this.electorates = this.model.electorates();
    this.positions = this.model.positions();
    this.regions = this.model.regions();

    this.listenTo(this.model, 'sync', this.render);

    // TODO let the subviews listen for themselves
    this.listenTo(this.foundedFractions, 'add', this.addFoundedFraction);
    this.listenTo(this.foundedFractions, 'remove', this.removeFoundedFraction);
    this.listenTo(this.children, 'add', this.addChild);
    this.listenTo(this.children, 'remove', this.removeChild);
    this.listenTo(this.electorates, 'add', this.addElectorate);
    this.listenTo(this.electorates, 'remove', this.removeElectorate);
    this.listenTo(this.positions, 'add', this.addPosition);
    this.listenTo(this.positions, 'remove', this.removePosition);
    this.listenTo(this.regions, 'add', this.addRegion);
    this.listenTo(this.regions, 'remove', this.removeRegion);

    // TODO add subviews in INITIALIZE for all composite views
    this.addSubviewForFoundedFractionsNew();
    this.addSubviewForFoundedFractions();
    // this.addSubviewForChildNew();
    this.addSubviewForChildren();
    this.addSubviewForElectoratesNew();
    this.addSubviewForElectorates();
    this.addSubviewForPositionsNew();
    this.addSubviewForPositions();
    this.addSubviewForRegionsNew();
    this.addSubviewForRegions();
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

  addSubviewForChildren: function () {
    this.children.each(this.addChild.bind(this));
  },

  addChild: function (child) {
    var view = new Fractions.Views.ListItem({
      model: child
    });
    this.addSubview('#children-list', view);
  },

  addSubviewForFoundedFractionsNew: function () {
    var view = new Fractions.Views.FractionsNew({
      childFractions: this.children,
      foundedFractions: this.foundedFractions,
      founder: this.model
    });
    this.addSubview('#founded-fractions-new', view);
  },

  addSubviewForFoundedFractions: function () {
    this.foundedFractions.each(this.addFoundedFraction.bind(this));
  },

  addFoundedFraction: function (child) {
    var view = new Fractions.Views.ListItem({
      model: child
    });
    this.addSubview('#founded-fractions-list', view);
  },

  addSubviewForElectoratesNew: function () {
    var view = new Fractions.Views.ElectoratesNew({
      collection: this.electorates,
      fraction: this.model
    });
    this.addSubview('#electorates-new', view);
  },

  addSubviewForElectorates: function () {
    this.electorates.each(this.addElectorate.bind(this));
  },

  addElectorate: function (electorate) {
    var view = new Fractions.Views.ListItem({
      model: electorate
    });
    this.addSubview('#electorates-list', view);
  },

  addSubviewForPositionsNew: function () {
    var view = new Fractions.Views.PositionsNew({
      collection: this.positions,
      fraction: this.model
    });
    this.addSubview('#positions-new', view);
  },

  addSubviewForPositions: function () {
    this.positions.each(this.addPosition.bind(this));
  },

  addPosition: function (position) {
    var view = new Fractions.Views.ListItem({
      model: position
    });
    this.addSubview('#positions-list', view);
  },

  addSubviewForRegionsNew: function () {
    var view = new Fractions.Views.RegionsNew({
      collection: this.regions,
      fraction: this.model
    });
    this.addSubview('#regions-new', view);
  },

  addSubviewForRegions: function () {
    this.regions.each(this.addRegion.bind(this));
  },

  addRegion: function (region) {
    var view = new Fractions.Views.ListItem({
      model: region
    });
    this.addSubview('#regions-list', view);
  },

  // TODO add remove methods for each collection ?
  // removeRegion: function (region) {
  //   var subview = _.find(this.subviews("#regions"), function (subview) {
  //     return subview.model === region;
  //   });
  //   this.removeSubview(".regions", subview);
  // },
});
