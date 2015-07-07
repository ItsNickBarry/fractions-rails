Fractions.Views.FractionShow = Backbone.CompositeView.extend({
  template: JST['fraction_show'],
  className: 'fractions-object-element fractions-object-show fractions-object-fraction',

  events: {

  },

  initialize: function () {
    this.positions = this.model.positions();
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.positions, 'add remove', this.addPosition);
  },

  render: function () {
    var content = this.template({ fraction: this.model });
    this.$el.html(content);
    this.renderPositionsNew();
    this.renderPositions();
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
  }
});
