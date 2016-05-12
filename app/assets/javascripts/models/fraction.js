Fractions.Models.Fraction = Backbone.Model.extend(
  Fractions.Concerns.Governable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Fraction',
  urlFragmentRoot: '/fractions',
  urlRoot: '/api/fractions',

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

    // parse and create accessor functions for NestedCollections
    [
      { name: 'electorates' },
      { name: 'positions' },
      { name: 'regions' },
      { name: 'children', noun: 'fraction' },
      { name: 'founded fractions', noun: 'fraction'}
    ].forEach(function (object) {
      var name = object.name;
      var noun = object.noun || _.singularize(name);
      var privateName = '_' + _.camelize(name);
      var snakeName = _.underscored(name);
      this[_.camelize(name)] = function () {
        if (!this[privateName]) {
          this[privateName] = new Fractions.Collections.NestedCollection({
            model: Fractions.Models[_.titleize(noun)],
            parentModel: this,
            name: name,
          });
        }
        return this[privateName];
      };

      // parse the collection
      this[_.camelize(name)]().set(response[name], { parse: true });
      delete response[name];

    }.bind(this));

    return response;
  },

  founder: function () {
    if (!this._founder) {
      this._founder = new Fractions.Models.Founder();
    }
    return this._founder;
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
});
