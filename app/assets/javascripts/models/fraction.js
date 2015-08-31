Fractions.Models.Fraction = Backbone.Model.extend({
  class: 'Fraction',
  urlFragmentRoot: '/fractions',
  urlRoot: '/api/fractions',

  parse: function (response) {
    // TODO refactor this into a loop
    // TODO parse founder and parent models
    if (response.children) {
      this.children().set(response.children, { parse: true });
      delete response.children;
    }
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

  children: function () {
    if (!this._children) {
      this._children = new Fractions.Collections.Fractions();
    }
    return this._children;
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
