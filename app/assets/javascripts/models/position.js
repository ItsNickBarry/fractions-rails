Fractions.Models.Position = Backbone.Model.extend({
  urlRoot: '/api/positions',

  parse: function (response) {
    if (response.characters) {
      this.characters().set(response.characters, { parse: true });
      delete response.characters;
    }
    return response;
  },

  characters: function () {
    if (!this._characters) {
      this._characters = new Fractions.Collections.Characters([], { fraction: this })
    }
    return this._characters;
  }
});
