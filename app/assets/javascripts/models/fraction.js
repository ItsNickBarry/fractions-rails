Fractions.Models.Fraction = Backbone.Model.extend(
Fractions.Concerns.Governable).extend({
  class: 'Fraction',
  urlFragmentRoot: '/fractions',
  urlRoot: '/api/fractions',

  urlFragment: function () {
    return '#' + this.urlFragmentRoot + '/' + this.get('id');
  },

  parse: function (response) {
    // TODO parse: true for founder and parent models?
    if (response.founder) {
      this.founder().set(response.founder);
      delete response.founder;
    }
    if (response.parent) {
      this.parent().set(response.parent);
      delete response.parent;
    }
    if (response.root) {
      this.root().set(response.root);
      delete response.root;
    }
    if (response.founded_fractions) {
      this.foundedFractions().set(response.founded_fractions, { parse: true });
      delete response.founded_fractions;
    }
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

  founder: function () {
    if (!this._founder) {
      this._founder = new Fractions.Models.Founder();
    }
    return this._founder
  },

  parent: function () {
    if (!this._parent) {
      this._parent = new Fractions.Models.Fraction();
    }
    return this._parent;
  },

  root: function () {
    if (!this._root) {
      this._root = new Fractions.Models.Fraction();
    }
    return this._root;
  },

  foundedFractions: function () {
    if (!this._founded_fractions) {
      this._founded_fractions = new Fractions.Collections.Fractions();
    }
    return this._founded_fractions;
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
