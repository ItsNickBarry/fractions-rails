Fractions.Models.Fraction = Backbone.Model.extend({
  urlRoot: '/api/fractions',

  parse: function (response) {
    // TODO refactor this into a loop
    if (response.positions) {
      this.positions().set(response.positions, { parse: true });
      delete response.positions;
    }
    if (response.regions) {
      this.region().set(response.regions, { parse: true });
      delete response.regions;
    }
    return response;
  },

  positions: function () {
    if (!this._positions) {
      this._positions = new Fractions.Collections.Positions([], { fraction: this });
    }
    return this._positions;
  },

  regions: function () {
    if (!this._regions) {
      this._regions = new Fractions.Collections.Regions([], { fraction: this });
    }
    return this._regions;
  },
});
