Fractions.Models.Fraction = Backbone.Model.extend({
  urlRoot: '/api/fractions',

  parse: function (response) {
    // TODO refactor this into a loop
    if (response.electorates) {
      this.electorates().set(response.electorates, { parse: true });
      delete response.electorates;
    }
    if (response.positions) {
      this.positions().set(response.positions, { parse: true });
      delete response.positions;
    }
    if (response.regions) {
      this.regions().set(response.regions, { parse: true });
      delete response.regions;
    }
    return response;
  },

  electorates: function () {
    if (!this._electorates) {
      this._electorates = new Fractions.Collections.Electorates();
    }
    return this._electorates;
  },

  positions: function () {
    if (!this._positions) {
      this._positions = new Fractions.Collections.Positions();
    }
    return this._positions;
  },

  regions: function () {
    if (!this._regions) {
      this._regions = new Fractions.Collections.Regions();
    }
    return this._regions;
  },
});
