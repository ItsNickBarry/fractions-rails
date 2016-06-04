Fractions.Concerns.Associable = {
  belongsTo: function (association, options) {
    options = options ? options : {};
    var className = options.className || _.capitalize(association);
    var privateName = '_' + association;
    this[association] = function (polymorphic_type) {
      if (!this[privateName]) {
        options;
        this[privateName] = new Fractions.Models[polymorphic_type || className]();
      }
      return this[privateName];
    };
    this._associations()[association] = {
      polymorphic: options.polymorphic,
      responseIndex: association,
    };
  },

  hasMany: function (association, options) {
    options = options ? options : {};
    var className = options.className || _.capitalize(_.singularize(association));
    var privateName = '_' + association;
    this[association] = function (polymorphic_type) {
      if (!this[privateName]) {
        this[privateName] = new Fractions.Collections.NestedCollection({
          model: Fractions.Models[className],
          parentModel: this,
          name: association,
        });
      }
      return this[privateName];
    };
    this._associations()[association] = {
      polymorphic: options.polymorphic,
      responseIndex: association,
    };
  },

  parse: function (response) {
    _.each(this._associations(), function (options, name) {
      if (response[options.responseIndex]) {
        var polymorphic_type;
        if (options.polymorphic) {
          polymorphic_type = response[name]['type'];
          delete response[name]['type'];
        }
        this[name](polymorphic_type).set(response[options.responseIndex], { parse: true });
        delete response[options.responseIndex];
      }
    }.bind(this));

    return response;
  },

  _associations: function () {
    if (typeof this._associationSet === 'undefined') {
      this._associationSet = {};
    }
    return this._associationSet;
  },
};
