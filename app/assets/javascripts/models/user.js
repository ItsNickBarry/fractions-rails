Fractions.Models.User = Backbone.Model.extend({
  urlFragmentRoot: '/users',
  urlRoot: '/api/users',

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
