Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST['fraction_show'],
  className: 'fractions-object-element fractions-object-show fractions-object-fraction',

  events: {

  },

  initialize: function () {
    this.positions = this.model.positions();
    this.regions = this.model.regions();
    
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.positions, 'add remove', this.addPosition);
    this.listenTo(this.regions, 'add remove', this.addRegion);
  },

  render: function () {
    var content = this.template({ fraction: this.model });
    this.$el.html(content);
    this.renderPositionsNew();
    this.renderPositions();
    this.renderRegionsNew();
    this.renderRegions();
    return this;
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
});
