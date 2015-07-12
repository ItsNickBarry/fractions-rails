Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST['fraction_show'],
  className: 'fractions-object-element fractions-object-show fractions-object-fraction',

  events: {

  },

  initialize: function () {
    this.children = this.model.children();
    this.electorates = this.model.electorates();
    this.positions = this.model.positions();
    this.regions = this.model.regions();

    this.listenTo(this.model, 'sync', this.render);

    this.listenTo(this.children, 'add', this.addChild);
    this.listenTo(this.children, 'remove', this.removeChild);
    this.listenTo(this.electorates, 'add', this.addElectorate);
    this.listenTo(this.electorates, 'remove', this.removeElectorate);
    this.listenTo(this.positions, 'add', this.addPosition);
    this.listenTo(this.positions, 'remove', this.removePosition);
    this.listenTo(this.regions, 'add', this.addRegion);
    this.listenTo(this.regions, 'remove', this.removeRegion);
  },

  render: function () {
    var content = this.template({ fraction: this.model });
    this.$el.html(content);
    this.renderChildNew();
    this.renderChildren();
    this.renderElectoratesNew();
    this.renderElectorates();
    this.renderPositionsNew();
    this.renderPositions();
    this.renderRegionsNew();
    this.renderRegions();
    return this;
  },

  renderChildNew: function () {
    var view = new Fractions.Views.FractionsNew({ collection: this.children, founder: this.model });
    this.addSubview('#children-new', view);
  },

  renderChildren: function () {
    this.children.each(this.addChild.bind(this));
  },

  addChild: function (child) {
    var view = new Fractions.Views.FractionListItem({ model: child });
    this.addSubview('#children', view);
  },

  renderElectoratesNew: function () {
    var view = new Fractions.Views.ElectoratesNew({ collection: this.electorates, fraction: this.model });
    this.addSubview('#electorates-new', view);
  },

  renderElectorates: function () {
    this.electorates.each(this.addElectorate.bind(this));
  },

  addElectorate: function (electorate) {
    var view = new Fractions.Views.ElectorateListItem({ model: electorate });
    this.addSubview('#electorates', view);
  },

  renderPositionsNew: function () {
    var view = new Fractions.Views.PositionsNew({ collection: this.positions, fraction: this.model });
    this.addSubview('#positions-new', view);
  },

  renderPositions: function () {
    this.positions.each(this.addPosition.bind(this));
  },

  addPosition: function (position) {
    var view = new Fractions.Views.PositionListItem({ model: position });
    this.addSubview('#positions', view);
  },

  renderRegionsNew: function () {
    var view = new Fractions.Views.RegionsNew({ collection: this.regions, fraction: this.model });
    this.addSubview('#regions-new', view);
  },

  renderRegions: function () {
    this.regions.each(this.addRegion.bind(this));
  },

  addRegion: function (region) {
    var view = new Fractions.Views.RegionListItem({ model: region });
    this.addSubview('#regions', view);
  },

  // TODO add remove methods for each collection
  // removeRegion: function (region) {
  //   var subview = _.find(this.subviews("#regions"), function (subview) {
  //     return subview.model === region;
  //   });
  //   this.removeSubview(".regions", subview);
  // },
});
