Fractions.Models.Fraction = Backbone.Model.extend(
  Fractions.Concerns.Governable
).extend(
  Fractions.Concerns.Routable
).extend({

  class: 'Fraction',
  urlFragmentRoot: '/fractions',
  urlRoot: '/api/fractions',

  parse: function (response) {
    if (response.founder) {
      this.founder(response.founder_type).set(response.founder);
      delete response.founder_type;
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
      { name: 'children', type: 'Fraction' },
      { name: 'founded fractions', type: 'Fraction'}
    ].forEach(function (object) {
      var name = object.name;
      var type = _.titleize(object.type || _.singularize(name));
      var privateName = '_' + _.camelize(name);
      var snakeName = _.underscored(name);
      this[_.camelize(name)] = function () {
        if (!this[privateName]) {
          this[privateName] = new Fractions.Collections.NestedCollection({
            model: Fractions.Models[type],
            parentModel: this,
            name: name,
          });
        }
        return this[privateName];
      };

      // parse the collection
      this[_.camelize(name)]().set(response[_.underscored(name)], { parse: true });
      delete response[_.underscored(name)];

    }.bind(this));

    return response;
  },

  founder: function (founder_type) {
    if (!this._founder && founder_type) {
      this._founder = new Fractions.Models[founder_type]();
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
