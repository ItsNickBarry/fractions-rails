Fractions.Models.Fraction = Backbone.Model.extend({
  urlRoot: '/api/fractions',

  parse: function (response) {
    if (response.positions) {
      this.positions().set(response.positions, { parse: true });
      delete response.positions;
    }
    return response;
  },

  positions: function () {
    if (!this._positions) {
      this._positions = new Fractions.Collections.Positions([], { fraction: this })
    }
    return this._positions;
  }
});
