Fractions.Models.Position = Backbone.Model.extend({
  urlFragmentRoot: '/positions',
  urlRoot: '/api/positions',

  parse: function (response) {
    if (response.characters) {
      this.characters().set(response.characters, { parse: true });
      delete response.characters;
    }
    if (response.fraction) {
      this.fraction().set(response.fraction, { parse: true });
      delete response.fraction;
    }
    return response;
  },

  characters: function () {
    if (!this._characters) {
      this._characters = new Fractions.Collections.Characters();
    }
    return this._characters;
  },

  fraction: function () {
    if (!this._fraction) {
      this._fraction = new Fractions.Models.Fraction();
    }
    return this._fraction;
  }
});
