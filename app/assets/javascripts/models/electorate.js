Fractions.Models.Electorate = Backbone.Model.extend({
  urlRoot: '/api/electorates',

  parse: function (response) {
    if (response.characters) {
      this.characters().set(response.characters, { parse: true });
      delete response.characters;
    }
    return response;
  },

  characters: function () {
    if (!this._characters) {
      this._characters = new Fractions.Collections.Characters();
    }
    return this._characters;
  }
});
